-- The video in a seminar's `youtube` front matter, then the PDF in its `pdf`,
-- go at the end of the page, unless the page already shows them with
-- {{< youtube >}} or {{< pdf >}} somewhere else. Runs after shortcodes are
-- expanded, and builds the embeds with the shortcodes in ../youtube.lua and
-- ../pdf.lua.
local embeds = {
  { key = "youtube", make = dofile(quarto.utils.resolve_path("../youtube.lua")).youtube,
    marker = function(id) return "youtube.com/embed/" .. id end },
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
