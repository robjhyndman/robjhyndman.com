HTMLWidgets.widget({

  name: 'pixgallery',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {
      renderValue: function(opts) {
        pixgallery_base(el,opts);
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});

function pixgallery_base(el,x){
  if(x.type === "box") pixgallery_box(el,x);
  if(x.type === "grid") pixgallery_grid(el,x);
}

/* flex box parent and children divs have images as img --------------------- */
function pixgallery_box(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;

  let temp = '<div class="pixgallery-child-box" style="flex-basis:{dim}" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-box" style="height:{dim};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {

    if(caption === null) {
     newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      if(caption[i] === null) {
        newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
      } else {
        newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
      }
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery-box" style="gap:' + gap + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_grid(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;

  let temp = '<div class="pixgallery-child-grid" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-grid" style="height:{dim};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {

    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + dim + ',1fr));grid-auto-rows:' + dim + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}
