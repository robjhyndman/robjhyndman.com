-- {{< slides >}}: HTML slides on a seminar page. Shows the title slide
-- (`image` in the front matter), replaced by the deck at `slides` when
-- clicked; the script that does this is in seminar.html.
return {
  slides = function(args, kwargs, meta)
    local url = pandoc.utils.stringify(meta.slides)
    local image = pandoc.utils.stringify(meta.image)
    return pandoc.RawBlock("html", string.format([[
<div class="slides-embed" data-slides="%s">
  <button type="button" class="slides-facade">
    <img src="%s" alt="Title slide">
    <span class="slides-play">View slides</span>
  </button>
</div>
<a href="%s" class="badge badge-small badge-red">Open slides in a new tab</a>
]], url, image, url))
  end
}
