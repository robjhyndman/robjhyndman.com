-- {{< youtube [id] >}}: a YouTube video. Without an id it uses the page's
-- `youtube` (seminar pages get that one added at the end if it isn't shown
-- elsewhere; see seminars/auto-embed.lua).
return {
  youtube = function(args, kwargs, meta)
    local id
    if #args > 0 then
      id = pandoc.utils.stringify(args[1])
    elseif meta.youtube then
      id = pandoc.utils.stringify(meta.youtube)
    else
      error("youtube shortcode: no id, and no `youtube` in the front matter")
    end
    return pandoc.RawBlock("html", string.format([[
<div class="embed video-player" style="padding-bottom: 4ex;">
  <iframe class="youtube-player" type="text/html" src="https://www.youtube.com/embed/%s" allowfullscreen frameborder="0">
  </iframe>
</div>]], id))
  end
}
