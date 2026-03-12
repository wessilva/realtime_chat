// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import MenuNavbarController from "controllers/menu_navbar_controller"
application.register("menu-navbar", MenuNavbarController)
