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
  return meta
end
