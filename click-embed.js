// Click-to-load embeds placed by youtube.lua and seminars/slides.lua: a
// thumbnail (or title slide) button that, when clicked, loads the iframe at
// the box's data-src behind it and then removes itself. Nothing heavy loads
// until the reader asks for it.
document.querySelectorAll(".click-embed").forEach((box) => {
  const button = box.querySelector(".click-facade");
  button.addEventListener("click", () => {
    button.disabled = true;
    button.querySelector(".click-play").textContent = box.dataset.loading;
    const frame = document.createElement("iframe");
    frame.title = box.dataset.title;
    frame.allow = "autoplay; encrypted-media; fullscreen; picture-in-picture";
    frame.allowFullscreen = true;
    frame.addEventListener("load", () => {
      button.remove();
      frame.focus();
    });
    frame.src = box.dataset.src;
    box.appendChild(frame);
  });
});
