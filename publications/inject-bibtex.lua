-- Looks up the page's `bibkey` in ~/git/CV/rjhpubs.bib (the CV repo's copy,
-- read directly -- this only ever runs on a machine that has that checkout)
-- and injects the raw BibTeX entry as a `bibtex` metadata field, rendered by
-- the "Cite" section in publication.html. Keeps the bib file the single
-- source of truth instead of typing the citation out a second time.
--
-- details/doi used to be filled in here too, computed from the same bib
-- entry -- but Quarto's `listing:` feature (which builds publications/
-- index.qmd) reads each file's raw YAML front matter directly and never
-- runs this filter, so a field only ever produced here never reached the
-- listing page. sync_bib_fields.R now writes details/doi into each file's
-- front matter before render (run by `make preview`/`make build`), which
-- both the listing and this filter's $doi$ template reference see. This
-- filter no longer needs to duplicate that.

local bib_cache = nil

local function read_file(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

-- Truncates a chunk at its true balanced closing brace, discarding any
-- trailing garbage between that point and the next entry (e.g. a stray
-- extra "}" left in the source .bib by a typo).
local function trim_to_balanced_entry(raw)
  local open_pos = raw:find("{")
  if not open_pos then return raw end
  local depth = 0
  local n = #raw
  for j = open_pos, n do
    local c = raw:sub(j, j)
    if c == "{" then
      depth = depth + 1
    elseif c == "}" then
      depth = depth - 1
      if depth == 0 then
        return raw:sub(1, j)
      end
    end
  end
  return raw -- unbalanced; fall back to the untrimmed chunk
end

-- rjhpubs.bib uses a couple of non-standard entry types ("report" instead
-- of the standard "techreport"; "review" -- a type this site invented for
-- book reviews -- instead of "article"). The source .bib is shared with the
-- CV repo, which relies on those types, so it can't change; this just
-- rewrites the type on the copy shown in the page's "Cite" block, so a
-- reader copy-pasting it into their own reference manager gets a type it
-- recognises.
local DISPLAY_TYPE_ALIASES = { report = "techreport", review = "article" }

-- Splits the .bib file into entries keyed by citation key. Entries are
-- first taken verbatim from "@type{key," up to (but not including) the
-- next line that starts with "@", so nested braces inside field values
-- never need to be balanced while scanning for entry boundaries, then
-- each chunk is trimmed to its own balanced close brace.
local function parse_bib(text)
  local entries = {}
  local lines = {}
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    table.insert(lines, line)
  end
  local starts = {}
  for i, l in ipairs(lines) do
    if l:match("^@") then table.insert(starts, i) end
  end
  table.insert(starts, #lines + 1)
  for i = 1, #starts - 1 do
    local chunk = {}
    for j = starts[i], starts[i + 1] - 1 do
      table.insert(chunk, lines[j])
    end
    local raw = trim_to_balanced_entry(table.concat(chunk, "\n"):gsub("%s+$", ""))
    local etype = chunk[1]:match("^@(%a+)")
    local alias = etype and DISPLAY_TYPE_ALIASES[etype:lower()]
    if alias then
      raw = raw:gsub("^@%a+", "@" .. alias, 1)
    end
    local key = chunk[1]:match("^@%a+%s*{%s*([^,]+),")
    if key then
      entries[(key:gsub("%s+$", ""))] = raw
    end
  end
  return entries
end

local function get_bib_entries()
  if bib_cache == nil then
    local home = os.getenv("HOME")
    local path = home and (home .. "/git/CV/rjhpubs.bib")
    local text = path and read_file(path)
    bib_cache = text and parse_bib(text) or {}
  end
  return bib_cache
end

-- Google Scholar (Highwire Press) <meta name="citation_*"> tags, built from
-- the same bib entry. Quarto's own `google-scholar: true` can't do this: it
-- reads only the page's raw front matter (never this filter's output), so
-- it would see `author` as one person and have no journal, volume, pages or
-- PDF; and it always emits citation_fulltext_html_url, which would wrongly
-- tell Scholar the page holds the full text rather than an abstract.

local SITE_URL = "https://robjhyndman.com"

local function attr_escape(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

local function str(v)
  if v == nil then return nil end
  -- pandoc joins multi-word surnames ("Ben Taieb") with no-break spaces
  local s = pandoc.utils.stringify(v):gsub("\u{a0}", " ")
  return s ~= "" and s or nil
end

-- Parses one entry into CSL with pandoc's biblatex reader, which handles the
-- LaTeX escapes, author lists and entry types. The reader rewrites English
-- titles into sentence case (lowercasing e.g. "Australia" in an unbraced
-- title); declaring a non-English langid makes it keep titles verbatim.
-- biblatex also treats institution/publisher/school as lists split on
-- " and " ("Australian Institute of Health and Welfare" would become two
-- names), so those values get an extra pair of braces.
local LIST_FIELDS = { institution = true, publisher = true, school = true, organization = true }

local function entry_csl(raw)
  local lines = {}
  for line in (raw .. "\n"):gmatch("([^\n]*)\n") do
    local pre, field, value, post = line:match("^(%s*(%a+)%s*=%s*){(.*)}(,?%s*)$")
    if field and LIST_FIELDS[field:lower()] then
      line = pre .. "{{" .. value .. "}}" .. post
    end
    table.insert(lines, line)
  end
  local src = table.concat(lines, "\n"):gsub("^(@%a+%s*{[^,]+,)", "%1 langid = {und},", 1)
  local ok, doc = pcall(pandoc.read, src, "biblatex")
  if not ok or not doc.meta.references then return nil end
  return doc.meta.references[1]
end

local function csl_name(n)
  if n.literal then return str(n.literal) end
  local parts = {}
  for _, k in ipairs({ "given", "dropping-particle", "non-dropping-particle", "family", "suffix" }) do
    local s = str(n[k])
    if s then table.insert(parts, s) end
  end
  return #parts > 0 and table.concat(parts, " ") or nil
end

-- The PDF the page's own "pdf" badge links to (title-metadata.html), when
-- it is on this site: Scholar only takes citation_pdf_url on the same site.
local function pdf_url(meta)
  local file = str(meta.file)
  if file then return SITE_URL .. "/papers/" .. file end
  local link = str(meta.link)
  if link and link:match("^/") and link:lower():match("%.pdf$") then
    return SITE_URL .. link
  end
  return nil
end

local function scholar_tags(csl, meta)
  local tags = {}
  local function add(name, value)
    if value then
      table.insert(tags, '<meta name="' .. name .. '" content="' .. attr_escape(value) .. '">')
    end
  end
  add("citation_title", str(csl.title))
  for _, n in ipairs(csl.author or {}) do
    add("citation_author", csl_name(n))
  end
  -- pandoc gives `issued` as an EDTF string ("2026", "2026-03"); Scholar
  -- wants slashes.
  local issued = str(csl.issued)
  add("citation_publication_date", issued and (issued:gsub("-", "/")))
  local container = str(csl["container-title"])
  local publisher = str(csl.publisher)
  local ctype = str(csl.type)
  if ctype == "article-journal" then
    add("citation_journal_title", container)
  elseif ctype == "paper-conference" then
    add("citation_conference_title", container)
  elseif ctype == "chapter" then
    add("citation_inbook_title", container)
    add("citation_publisher", publisher)
  elseif ctype == "book" then
    add("citation_publisher", publisher)
  elseif ctype == "report" then
    add("citation_technical_report_institution", publisher)
    add("citation_technical_report_number", str(csl.number))
  elseif ctype == "thesis" then
    add("citation_dissertation_institution", publisher)
  end
  add("citation_volume", str(csl.volume))
  add("citation_issue", str(csl.issue))
  local page = str(csl.page)
  if page then
    local first, last = page:match("^%s*(%S-)%s*[-–]+%s*(%S+)%s*$")
    add("citation_firstpage", first or page)
    add("citation_lastpage", last)
  end
  add("citation_doi", str(csl.DOI) or str(meta.doi))
  add("citation_pdf_url", pdf_url(meta))
  return tags
end

function Meta(meta)
  if not meta.bibkey then
    return meta
  end
  local key = pandoc.utils.stringify(meta.bibkey)
  local raw = get_bib_entries()[key]
  if not raw then
    quarto.log.warning("inject-bibtex: bibkey '" .. key .. "' not found in rjhpubs.bib")
    return meta
  end
  meta.bibtex = pandoc.MetaBlocks({ pandoc.CodeBlock(raw, { class = "bibtex" }) })
  local csl = entry_csl(raw)
  if csl then
    quarto.doc.include_text("in-header", table.concat(scholar_tags(csl, meta), "\n"))
  else
    quarto.log.warning("inject-bibtex: could not parse bib entry '" .. key .. "'")
  end
  return meta
end
