import Swiper from 'swiper';
const basicLightbox = require('basiclightbox');

function init() {
  new Swiper('.swiper-container', {
    pagination: '.swiper-pagination',
    slidesPerView: 'auto',
    paginationClickable: true,
    keyboardControl: true,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
  });
};

document.addEventListener('DOMContentLoaded', init, false);

const lightbox = basicLightbox.create(`
<div class="pa4">
  <img>
  <p class="ma2 f6 near-white"></p>
</div>
`);
let active;
const images = Array.from(document.querySelectorAll('.lightbox img'));

function activeImage() {
  return lightbox.element().querySelector('img');
}

function activeCaption() {
  return lightbox.element().querySelector('p');
}

function render(img) {
  activeImage().src = '';
  activeImage().src = img.src;
  if (img.alt) {
    activeCaption().innerText = img.alt;
  } else {
    activeCaption().innerText = '';
  }
}

images.forEach((img, index) => {
  const open = function () {
    if (window.matchMedia("(max-width: 40em)").matches) {
      return;
    }
    render(img);
    active = index;
    lightbox.show();
  }
  img.addEventListener('click', open, false)
});

function prev() {
  if (active > 0) {
    render(images[active - 1]);
    active--;
  }
}

function next() {
  if (active < images.length - 1) {
    render(images[active + 1]);
    active++;
  }
}

function onKey(event) {
  if (!lightbox.visible()) {
    return;
  }

  switch (event.key) {
    case 'Escape':
      lightbox.close();
      break;
    case 'ArrowLeft':
      prev();
      break;
    case 'ArrowRight':
      next();
      break;
  }
}

document.addEventListener('keydown', onKey, false);
