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

const lightbox = basicLightbox.create('<img>');
let active;
const images = Array.from(document.querySelectorAll('.lightbox img'));

function activeImage() {
  return lightbox.element().querySelector('img');
}

images.forEach((img, index) => {
  const open = function () {
    if (window.matchMedia("(max-width: 40em)").matches) {
      return;
    }
    activeImage().src = '';
    activeImage().src = img.src;
    active = index;
    lightbox.show();
  }
  img.addEventListener('click', open, false)
});

function prev() {
  if (active > 0) {
    activeImage().src = '';
    activeImage().src = images[active - 1].src
    active--;
  }
}

function next() {
  if (active < images.length - 1) {
    activeImage().src = '';
    activeImage().src = images[active + 1].src
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
