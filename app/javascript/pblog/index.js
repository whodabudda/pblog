import ("pblog/manifest.json")
//import ("pblog/push_notification.js.erb")
//import ("pblog/sw_push.js.erb")
//import { checkBrowserSupport } from "pblog/user_options_form.js";
//window.checkBrowserSupport = checkBrowserSupport
import checkBrowserSupport from "expose-loader?checkBrowserSupport!./user_options_form.js"
import ("pblog/welcome.js")
