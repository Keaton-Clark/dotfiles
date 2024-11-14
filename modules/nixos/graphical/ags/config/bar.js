
const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const hour = Variable("", {
    poll: [1000, 'date "+%H"'],
})
const minute = Variable("", {
    poll: [1000, 'date "+%M"'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.sort((a, b) => b.id - a.id).map(({ name, id }) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${name}`),
            child: Widget.Label(`${name}`),
            class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
        })))
    
    return Widget.Box({
        spacing: 15,
        vertical: true,
        class_name: "workspaces",
        children: workspaces,
    })
}


function Clock() {
    return Widget.Box({
        class_name: "clock",
        vertical: true,
        children: [
            Widget.Label({
                label: hour.bind()
            }),
            Widget.Label({
                label: minute.bind()
            }),
        ],
    })
}


// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Icon({
                icon: "preferences-system-notifications-symbolic",
            }),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}


function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0]
            return `${track_artists.join(", ")} - ${track_title}`
        } else {
            return "Nothing is playing"
        }
    })

    return Widget.Button({
        class_name: "media",
        on_primary_click: () => mpris.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.getPlayer("")?.next(),
        on_scroll_down: () => mpris.getPlayer("")?.previous(),
        child: Widget.Label({ label }),
    })
}


function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const show = Variable(false)

    const slider = Widget.Revealer({
        revealChild: show.bind(),
        transition: "slide_up",
        transitionDuration: 500,
        child: Widget.Box({ 
            css: "min-height: 100px;",
            children: [
                Widget.Slider({
                    vertical: true,
                    draw_value: false,
                    inverted: true,
                    min: 0,
                    max: 100,
                    on_change: ({ value }) => audio.speaker.volume = value/100,
                    setup: self => self.hook(audio.speaker, () => {
                        self.value = audio.speaker.volume/100 || 0
                    }),
                })
            ]
        })
    })

    const value = Widget.Label({
        label: audio.speaker.bind("volume").as(p => `${Math.round(p*100)}%`)
    })

    return Widget.EventBox({ 
        on_hover: ({_}) => show.setValue(true),
        on_hover_lost: ({_}) => show.setValue(false),
        child: Widget.Box({
                class_name: "volume",
                vertical: true,
                children: [slider, icon, value],
        })
    })
}


function BatteryLabel() {
    const label = battery.bind("percent").as(p => p > 0 ? `${p}%` : "")
    const icon = battery.bind("percent").as(p =>
        `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

    return Widget.Button({
        class_name: "battery",
        visible: battery.bind("available"),
        on_clicked: () => {"bash -c "},
        child: 
            Widget.Box({
                vertical: true,
                children: [
                    Widget.Icon({ icon }),
                    Widget.Label({ label })
                ]
            }),
    })
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        children: items,
    })
}


// layout of the bar
function Top() {
    return Widget.Box({
        spacing: 8,
        class_name: "section",
        children: [
            Notification(),
        ],
    })
}

function Middle() {
    return Widget.Box({
        spacing: 8,
        vertical: true,
        class_name: "section",
        vpack: "start",
        children: [
            Workspaces(),
        ],
    })
}

function Bottom() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        vertical: true,
        class_name: "section",
        vpack: "end",
        children: [
            BatteryLabel(),
            Volume(),
            Clock(),
        ],
    })
}

function SideBar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "right", "bottom"],
        exclusivity: "exclusive",
        margins: [ 9,7,10,7 ],
        child: Widget.CenterBox({
            vertical: true,
            start_widget: Top(),
            center_widget: Middle(),
            end_widget: Bottom(),
        }),
    })
}

function Launcher(monitor = 0) {
    const entry = Widget.Entry({
        placeholder_text: 'type here',
        text: 'initial text',
        visibility: true, // set to false for passwords
        onAccept: ({ text }) => print(text),
    })
    return Widget.Window({
        name: `launcher-${monitor}`,
        monitor,
        visible: false,
        layer: "overlay",
        keymode: "on-demand",
        child: Widget.Box({
            css: "padding: 20px; background-color: red;",
            children: [
                entry,
            ],
        })
    })
}
export { SideBar }
