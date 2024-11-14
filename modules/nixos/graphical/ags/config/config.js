import { applauncher } from "./launcher.js"
import { SideBar } from "./bar.js"
App.config({
    style: "./style.css",
    windows: [
        SideBar(),
        applauncher
    ],
})

