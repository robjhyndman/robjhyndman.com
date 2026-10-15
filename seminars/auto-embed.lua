-- The PDF in a seminar's `pdf` front matter goes at the end of the page,
-- unless the page already shows it with {{< pdf >}} somewhere else. Runs
-- after shortcodes are expanded, and builds the embed with the shortcode in
-- ../pdf.lua.
local embeds = {
  { key = "pdf", make = dofile(quarto.utils.resolve_path("../pdf.lua")).pdf,
    marker = function(url) return 'data-pdf="' .. url .. '"' end },
}

function Pandoc(doc)
  local html = {}
  doc:walk({ RawBlock = function(raw) table.insert(html, raw.text) end })
  html = table.concat(html, "\n")
  for _, embed in ipairs(embeds) do
    local value = doc.meta[embed.key]
    if value and not html:find(embed.marker(pandoc.utils.stringify(value)), 1, true) then
      doc.blocks:insert(embed.make({}, {}, doc.meta))
    end
  end
  return doc
end
