import Swiper from 'swiper';

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
