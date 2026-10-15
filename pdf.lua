-- {{< pdf [url] [fullpage=true] >}}: a PDF drawn with PDF.js by pdf-embed.js,
-- which works on mobile browsers where an <iframe> of a PDF shows only the
-- first page or nothing. Without a url it uses the page's `pdf` (seminar
-- pages get that one added at the end if it isn't shown elsewhere; see
-- seminars/auto-embed.lua). By default the pages are shown one at a time in a box,
-- with a download link below (seminar slides). fullpage=true fills the window
-- with the browser's own PDF viewer where it has one, and with the pages
-- stacked otherwise (CV).
return {
  pdf = function(args, kwargs, meta)
    local url
    if #args > 0 then
      url = pandoc.utils.stringify(args[1])
    elseif meta.pdf then
      url = pandoc.utils.stringify(meta.pdf)
    else
      error("pdf shortcode: no url, and no `pdf` in the front matter")
    end
    local script = '<script type="module" src="/pdf-embed.js"></script>'
    if kwargs.fullpage and pandoc.utils.stringify(kwargs.fullpage) == "true" then
      return pandoc.RawBlock("html", string.format(
        '<div class="pdf-embed pdf-fullpage" data-pdf="%s"></div>\n%s', url, script))
    end
    return pandoc.RawBlock("html", string.format([[
<div class="pdf-embed" data-pdf="%s"></div>
<a href="%s" class="badge badge-small badge-red">Download pdf</a>
%s]], url, url, script))
  end
}
