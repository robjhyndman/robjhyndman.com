-- {{< slides >}}: HTML slides on a seminar page. Shows the title slide
-- (`image` in the front matter), replaced by the deck at `slides` when
-- clicked (click-embed.js).
return {
  slides = function(args, kwargs, meta)
    local url = pandoc.utils.stringify(meta.slides)
    local image = pandoc.utils.stringify(meta.image)
    return pandoc.RawBlock("html", string.format([[
<div class="click-embed" data-src="%s" data-title="Slides" data-loading="Loading slides…">
  <button type="button" class="click-facade">
    <img src="%s" alt="Title slide">
    <span class="click-play">View slides</span>
  </button>
</div>
<script type="module" src="/click-embed.js"></script>
<a href="%s" class="badge badge-small badge-red">Open slides in a new tab</a>
]], url, image, url))
  end
}
