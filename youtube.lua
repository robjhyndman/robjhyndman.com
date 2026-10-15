-- {{< youtube [id] >}}: a YouTube video, shown as its thumbnail until clicked
-- (click-embed.js), so the player only loads for readers who want it. Without
-- an id it uses the page's `youtube` (seminar pages get that one added at the
-- end if it isn't shown elsewhere; see seminars/auto-embed.lua). The id may
-- carry a start time, as YouTube's share links do: `ID?t=3688` or `ID?t=5m41s`.
local function seconds(t)
  if t:match("^%d+$") then
    return tonumber(t)
  end
  return (tonumber(t:match("(%d+)h")) or 0) * 3600
    + (tonumber(t:match("(%d+)m")) or 0) * 60
    + (tonumber(t:match("(%d+)s")) or 0)
end

return {
  youtube = function(args, kwargs, meta)
    local value
    if #args > 0 then
      value = pandoc.utils.stringify(args[1])
    elseif meta.youtube then
      value = pandoc.utils.stringify(meta.youtube)
    else
      error("youtube shortcode: no id, and no `youtube` in the front matter")
    end
    local id = value:match("^[%w_-]+")
    local t = value:match("[?&]t=(%w+)")
    local src = "https://www.youtube.com/embed/" .. id .. "?autoplay=1"
      .. (t and ("&start=" .. seconds(t)) or "")
    return pandoc.RawBlock("html", string.format([[
<div class="click-embed" data-youtube="%s" data-src="%s" data-title="YouTube video" data-loading="Loading video…">
  <button type="button" class="click-facade">
    <img src="https://i.ytimg.com/vi/%s/hqdefault.jpg" alt="" loading="lazy">
    <span class="click-play">Play video</span>
  </button>
</div>
<script type="module" src="/click-embed.js"></script>]], value, src, id))
  end
}
