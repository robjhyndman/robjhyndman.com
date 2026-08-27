-- Looks up the page's `bibkey` in the repo-root rjhpubs.bib (fetched fresh
-- from robjhyndman/CV by fetch_bib.R before every build) and injects the raw
-- BibTeX entry as a `bibtex` metadata field, rendered by the "Cite" section
-- in publication.html. Keeps the bib file the single source of truth instead
-- of typing citation details twice.

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
    local key = chunk[1]:match("^@%a+%s*{%s*([^,]+),")
    if key then
      entries[(key:gsub("%s+$", ""))] = raw
    end
  end
  return entries
end

local function get_bib_entries()
  if bib_cache == nil then
    local path = quarto.project.directory .. "/rjhpubs.bib"
    local text = read_file(path)
    bib_cache = text and parse_bib(text) or {}
  end
  return bib_cache
end

-- Pulls a single field's value out of a raw bib entry, matching balanced
-- braces so values with nested braces are captured whole.
local function get_field(raw, field)
  local s, e = raw:find("%f[%a]" .. field .. "%f[%A]%s*=%s*")
  if not s then return nil end
  local pos = e + 1
  if raw:sub(pos, pos) == "{" then
    local depth = 0
    local start = pos
    local n = #raw
    local j = pos
    while j <= n do
      local c = raw:sub(j, j)
      if c == "{" then
        depth = depth + 1
      elseif c == "}" then
        depth = depth - 1
        if depth == 0 then j = j + 1; break end
      end
      j = j + 1
    end
    return raw:sub(start + 1, j - 2)
  end
  local vs, ve = raw:find("[^,\n}]+", pos)
  return vs and raw:sub(vs, ve) or nil
end

-- Unescapes the handful of LaTeX sequences that show up in bib text fields
-- (journal names, mostly): protective braces around a word, and the escaped
-- punctuation BibTeX requires ("\&", "\$").
local function unescape_latex(s)
  s = s:gsub("\\&", "&"):gsub("\\%$", "$"):gsub("[{}]", "")
  return s
end

-- Builds the "<em>Journal</em> <b>Vol</b>(No), Pages" details string, the
-- house style used across the site for journal-article citations. Only
-- article/review entries have that fixed journal/volume/number/pages shape
-- -- inbook, incollection, inproceedings, techreport, report and phdthesis
-- entries are each written up by hand (chapter numbers, editors, conference
-- venues, publishers) in ways that can't be reconstructed from structured
-- fields, and techreport/unpublished entries rely on details being *absent*
-- so the "Working paper" fallback in title-metadata.html shows instead. So,
-- like title/author, those are left for the author to write themselves.
local function build_details(raw, entry_type)
  if entry_type ~= "article" and entry_type ~= "review" then
    return nil
  end
  local journal = get_field(raw, "journal")
  if not journal then
    return nil
  end
  journal = unescape_latex(journal)
  local volume = get_field(raw, "volume")
  local number = get_field(raw, "number")
  local pages = get_field(raw, "pages")
  if pages then
    -- Page ranges always render with an en dash, whether the bib wrote the
    -- range with BibTeX's "--" convention or a plain "-".
    pages = pages:gsub("(%d)%-%-?(%d)", "%1–%2")
  end

  local out = "<em>" .. journal .. "</em>"
  if volume then
    out = out .. " <b>" .. volume .. "</b>"
    if number then
      out = out .. "(" .. number .. ")"
    end
    if pages then
      out = out .. ", " .. pages
    end
  elseif pages then
    out = out .. ", " .. pages
  end
  return out
end

-- title/author can't safely be generated this way: Quarto resolves the
-- browser-tab <title> (pagetitle) and the "Authors" byline (by-author) from
-- the raw YAML before Pandoc's Lua filters run, so setting meta.title /
-- meta.author here has no effect on either. doi has no such special
-- handling -- the custom publication.html template just reads $doi$
-- directly -- so it's one of the fields this filter can safely fill in.
-- details is the other: build_details() above covers the article/review
-- case, which is most entries; everything else is left alone.
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
  if not meta.doi then
    local doi = get_field(raw, "doi")
    if doi then
      meta.doi = pandoc.MetaString((doi:gsub("%s+", "")))
    end
  end
  if not meta.details then
    local entry_type = raw:match("^@(%a+)")
    local details = build_details(raw, entry_type and entry_type:lower() or nil)
    if details then
      meta.details = pandoc.MetaInlines({ pandoc.RawInline("html", details) })
    end
  end
  return meta
end
