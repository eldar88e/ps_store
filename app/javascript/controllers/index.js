import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NoticesController from "./notices_controller"
application.register("notices", NoticesController)

import FancyboxController from "./fancybox_controller"
application.register('fancybox', FancyboxController);