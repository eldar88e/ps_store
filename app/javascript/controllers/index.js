import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NoticesController from "./notices_controller"
application.register("notices", NoticesController)

import FancyboxController from "./fancybox_controller"
application.register('fancybox', FancyboxController);

import PagyInitializerController from "./pagy_initializer_controller";
application.register('pagy_initializer', PagyInitializerController);

import SwiperController from "./swiper_controller";
application.register('swiper', SwiperController);

import RecentlySwiperController from "./recently_swiper_controller";
application.register('recently_swiper', RecentlySwiperController);
