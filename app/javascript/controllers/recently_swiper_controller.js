import { Controller } from "@hotwired/stimulus";
import Swiper from 'swiper';
import { Navigation, Autoplay } from 'swiper/modules';

export default class extends Controller {
    connect() {
      this.swiper = new Swiper('.recently_swiper', {
        modules: [Navigation, Autoplay],

        // Optional parameters
        slidesPerView: 4,
        spaceBetween: 20,
        breakpoints: {
          // when window width is >= 320px
          320: {
            slidesPerView: 1,
            spaceBetween: 0
          },
          // when window width is >= 480px
          480: {
            slidesPerView: 2,
            spaceBetween: 10
          },
          // when window width is >= 768px
          768: {
            slidesPerView: 3,
            spaceBetween: 15
          },
          // when window width is >= 992px
          992: {
            slidesPerView: 4,
            spaceBetween: 20
          }
        },
        loop: true,
        autoplay: {
          delay: 3000,
        },

        // Navigation arrows
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
      });
    }
}
