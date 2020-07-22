# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401

mod = "mod4"

keys = [
    # === Qtile === #
    # Switch between windows in current stack pane
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    # Move windows up or down in current stack
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    # Change window sizes (MonadTall)
    Key([mod, "shift"], "Left", lazy.layout.shrink()),
    Key([mod, "shift"], "Right", lazy.layout.grow()),
    # Toggle floating
    Key([mod, "shift"], "f", lazy.window.toggle_floating()),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    # Kill window
    Key([mod], "q", lazy.window.kill()),
    Key([], "Cancel", lazy.window.kill()),
    # Restart Qtile
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    # Key([mod], "r", lazy.spawncmd()),
    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),
    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # === Applications === #
    # Menu
    Key([mod], "Return", lazy.spawn("rofi -show run")),
    # Window Nav
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show")),
    # File Explorer
    Key([mod], "f", lazy.spawn("nautilus")),
    Key([], "XF86HomePage", lazy.spawn("nautilus")),
    # Terminal
    Key([mod], "t", lazy.spawn("alacritty")),
    # Browser
    Key([mod], "b", lazy.spawn("google-chrome-stable")),
    Key([], "XF86Mail", lazy.spawn("google-chrome-stable https://hotmail.com")),
    # Spotify
    Key([], "XF86Tools", lazy.spawn("gtk-launch spotify.desktop")),

    # === Hardware Configs === #
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=playerctld play-pause")), #Key([], "XF86AudioPlay", lazy.spawn("omnipause toggle")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=playerctld previous")), #Key([], "XF86AudioPrev", lazy.spawn("omnipause previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=playerctld next")), #Key([], "XF86AudioNext", lazy.spawn("omnipause next")),
    Key([mod], "XF86AudioPlay", lazy.spawn("playerctl --all-players stop")),
]

groups = [Group(i) for i in ["   ", "   ", "   ", "   ", "   ", "   ", "   "]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
    # Switch to workspace N
    Key([mod], actual_key, lazy.group[group.name].toscreen()),
    # Send window to workspace N
    Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])

layouts = [
    layout.Bsp(),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    padding=10,
                    scale=0.6,
                ),
                widget.GroupBox(                    
                    highlight_method = "block",
	                urgent_alert_method = "block",

                    active = '#FDF0ED',
	                inactive = '#6C6F93',
                    block_highlight_text_color='#B877DB',
                    fontshadow='#16161C',
	                urgent_text = '#E95379',
	                urgent_border = '#2E303E',
	                this_current_screen_border = '#2E303E',
	                this_screen_border = '#1e252c',
	                other_current_screen_border = '#2E303E',
	                other_screen_border = '#1e252c',
	                # background = '#B877DB',

                    margin=3,
                    padding=3,
                    rounded=False,
                    spacing=5,

                    disable_drag=True,
                    # hide_unused=True,
                    ),

                # widget.CPU(),
                # widget.CPUGraph(),
                # widget.Memory(),
                # widget.MemoryGraph(),

                # widget.Pomodoro(),
                # widget.Pacman(),
                # widget.PulseVolume(),
                # widget.Sep(),
                # widget.Systray(),
                # widget.TaskList(),
                # widget.Volume(),

                # widget.Prompt(),
                # widget.WindowName(),
                # widget.TextBox("default config", name="default"),
                # widget.Systray(),
                # widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                # widget.QuickExit(),
            ],
            size=30,
            opacity=1.0,
            background="#1A2026",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
