// PDFs drawn with PDF.js, which works on mobile browsers where an <iframe> of
// a PDF shows only the first page or nothing. Each <div class="pdf-embed"
// data-pdf="URL"> on the page (from the {{< pdf >}} shortcode, pdf.lua)
// becomes a box showing one page at a time (seminar slides). A pdf-fullpage
// box (CV) fills the window: with the browser's own PDF viewer where it has
// one, and otherwise with a download link and the pages stacked.

document.querySelectorAll(".pdf-fullpage").forEach(box => {
  if (navigator.pdfViewerEnabled && !matchMedia("(pointer: coarse)").matches) {
    box.classList.remove("pdf-embed");
    box.innerHTML = `<iframe src="${box.dataset.pdf}" title="PDF"></iframe>`;
  } else {
    box.classList.add("pdf-document");
    box.innerHTML = `<a href="${box.dataset.pdf}" class="badge badge-small badge-red">Download pdf</a>`;
  }
});

const boxes = document.querySelectorAll(".pdf-embed");
if (boxes.length) {
  const base = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.10.38/";
  const pdfjs = await import(base + "pdf.min.mjs");
  pdfjs.GlobalWorkerOptions.workerSrc = base + "pdf.worker.min.mjs";
  boxes.forEach(box => show(box, pdfjs).catch(() => {
    box.innerHTML = "The PDF could not be displayed here. " +
      `<a href="${box.dataset.pdf}">Download it</a> instead.`;
    box.classList.add("pdf-error");
  }));
}

async function show(box, pdfjs) {
  // github.com/<repo>/raw/ redirects without CORS headers; its target allows them
  const url = box.dataset.pdf.replace(
    /^https:\/\/github\.com\/([^/]+\/[^/]+)\/raw\//,
    "https://raw.githubusercontent.com/$1/");
  const pdf = await pdfjs.getDocument(url).promise;
  const pages = [];
  for (let i = 1; i <= pdf.numPages; i++) {
    const page = await pdf.getPage(i);
    const view = page.getViewport({ scale: 1 });
    const div = document.createElement("div");
    div.className = "pdf-page";
    div.style.aspectRatio = view.width + " / " + view.height;
    div.page = page;
    addLinks(div, page, view);
    box.appendChild(div);
    pages.push(div);
  }
  const stacked = box.classList.contains("pdf-document");
  if (!stacked) {
    // The box shows one page at a time
    new ResizeObserver(() => {
      box.style.height = pages[0].offsetHeight + "px";
    }).observe(pages[0]);
  }
  // Draw pages as they come near the view, and drop them when they are far
  // away, so a long document doesn't exhaust a phone's canvas memory
  const seen = new IntersectionObserver(entries => entries.forEach(e => {
    const div = e.target;
    if (!e.isIntersecting) {
      div.querySelector("canvas")?.remove();
      return;
    }
    if (div.querySelector("canvas")) return;
    const page = div.page;
    const scale = div.clientWidth * Math.min(devicePixelRatio, 2) /
      page.getViewport({ scale: 1 }).width;
    const view = page.getViewport({ scale });
    const canvas = document.createElement("canvas");
    canvas.width = view.width;
    canvas.height = view.height;
    canvas.setAttribute("aria-label", "Page " + page.pageNumber);
    div.prepend(canvas);
    page.render({ canvasContext: canvas.getContext("2d"), viewport: view });
  }), { root: stacked ? null : box, rootMargin: "100% 0px" });
  pages.forEach(div => seen.observe(div));
}

// Clickable web links over the drawn page
async function addLinks(div, page, view) {
  for (const a of await page.getAnnotations()) {
    if (a.subtype !== "Link" || !a.url) continue;
    const [x1, y1, x2, y2] = view.convertToViewportRectangle(a.rect);
    const link = document.createElement("a");
    link.href = a.url;
    link.className = "pdf-link";
    link.style.left = Math.min(x1, x2) / view.width * 100 + "%";
    link.style.top = Math.min(y1, y2) / view.height * 100 + "%";
    link.style.width = Math.abs(x2 - x1) / view.width * 100 + "%";
    link.style.height = Math.abs(y2 - y1) / view.height * 100 + "%";
    div.appendChild(link);
  }
}
