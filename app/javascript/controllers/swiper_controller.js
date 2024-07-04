import { Controller } from "@hotwired/stimulus";
import Swiper from 'swiper';
import { Navigation, Pagination, Scrollbar, Autoplay } from 'swiper/modules';

export default class extends Controller {
    connect() {
      this.swiper = new Swiper('.swiper', {
        modules: [Navigation, Pagination, Scrollbar, Autoplay],

        // Optional parameters
        direction: 'horizontal',
        loop: true,
        effect: 'flip',
        autoplay: {
          delay: 5000,
        },

        // If we need pagination
        pagination: {
          el: '.swiper-pagination',
        },

        // Navigation arrows
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },

        // And if we need scrollbar
        scrollbar: {
          el: '.swiper-scrollbar',
        },
      });
    }
}
