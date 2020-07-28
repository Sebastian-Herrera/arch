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
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    # # Change window sizes (MonadTall)
    # Key([mod, "shift"], "Left", lazy.layout.shrink()),
    # Key([mod, "shift"], "Right", lazy.layout.grow()),
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
    # Sound
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=playerctld play-pause")), #("omnipause toggle"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=playerctld previous")), #("omnipause previous"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=playerctld next")), #("omnipause next"),
    Key([mod], "XF86AudioPlay", lazy.spawn("playerctl --all-players stop")),
    #Screenshot
    Key([], "Print", lazy.spawn("escrotum")),
]

groups = [Group(i) for i in ["   ", " ﬏  ", "   ", "   ", "   ", "   ", "   "]] # 

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
    # Switch to workspace N
    Key([mod], actual_key, lazy.group[group.name].toscreen()),
    # Send window to workspace N
    Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])

layouts = [
    layout.Bsp(
        border_focus='#CD84C8',
        border_normal='#6C6F93',
        border_width=2,
        margin=15,
    ),
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
    # font='sans',
    # font='SF UI Display',
    font='Iosevka Custom',
    # font='DroidSansMono Nerd Font',
    fontshadow='#000000',
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    " 異 ",
                    #   space
                    # 異  nf-mdi-rocket
                    #   nf-fae-grav
                    #   nf-fae-galaxy
                    #   nf-fae-telescope
                    #  
                    foreground="#6C6F93", #color16
                    fontsize=23,
                    ),
                widget.GroupBox(                    
                    highlight_method = "block",
	                urgent_alert_method = "block",

                    active = '#F4F5F2', #color15
	                inactive = '#6C6F93', #color16
                    block_highlight_text_color='#CD84C8', #color5
                    fontshadow='#000000',
	                urgent_text = '#FB6396', #color1
	                urgent_border = '#2E303E', #color0
	                this_current_screen_border = '#2E303E', #color0
	                this_screen_border = '#1e252c', #background1
	                other_current_screen_border = '#2E303E', #color0
	                other_screen_border = '#1e252c', #background1
	                # background = '#CD84C8', #color5

                    margin=3,
                    padding=3,
                    rounded=False,
                    spacing=5,

                    disable_drag=True,
                    # hide_unused=True,

                    # ﵁  ﰧ  nf-mdi-view nf-mdi-view_dashboard_variant nf-mdi-view_sequential
                    # ﬿  nf-mdi-collage
                    #   nf-fa-th_large
                    ),
                widget.TaskList(
                    highlight_method='block',
                    title_width_method='uniform',
                    urgent_alert_method='block',

                    foreground='#6C6F93',
                    border='#2E303E',
                    unfocused_border='#1e252c',
                    urgent_border='#FB6396',
                    font='DroidSansMono Nerd Font',
                    fontshadow=None,
                    icon_size=0,

                    markup_normal='  {}',
                    markup_focused='<span foreground="#CD84C8">  {}</span>',
                    markup_minimized='<span foreground="#6C6F93" strikethrough_color="#4CB9D6">  <s>{}</s></span>', #  nf-fa-caret_up   circle   expand   compress   toggle   drop_circle
                    markup_floating=None,
                    markup_maximized=None,
                    # markup_focused='<span foreground="#94CF95"></span>  {}',
                    # markup_minimized="<b>This is bold.</b> <i>This is itallic.</i> <s>This is strikethrough.</s> <sub>This is subscript.</sub>",
                    # markup_minimized="<sup>This is superscript.</sup> <small>This makes the font smaller.</small> <big>This makes the font larger.</big>",
                    # markup_minimized="<u>This is underlined text.</u> <tt>This uses a Monospace font.</tt> This is normal text UNCHANGED.", 
                    # markup_minimized="<span foreground='blue'>Blue text (single quotes here)!</span> <span size='x-large'>Extra Large Text</span>",
                    # markup_minimized="<span font='30' foreground='red'>30 point text.</span>",

                    # borderwidth=2,
                    margin=3,
                    # margin_x=None,
                    # margin_y=None,
                    padding=3,
                    # padding_x=None,
                    # padding_y=None,
                    rounded=False,
                    spacing=5,
                ),
                # widget.CPU(),
                # widget.CPUGraph(),
                # widget.Memory(),
                # widget.MemoryGraph(),
                # widget.SwapGraph(),
                # widget.HDDBusyGraph(),
                # widget.HDDGraph(),
                widget.TextBox(
                    "",
                    # ⏽   nf-iec-power_on
                    #    nf-fa-ellipsis_v
                    #    dot
                    #    nf-mdi-drag_vertical
                    #    nf-mdi-menu_right
                    #    nf-pl-left_hard_divider
                    #   nf-oct-triangle
                    foreground="#6C6F93", #color16
                    fontsize=20,
                    ),
                # widget.Notify(),
                widget.Pomodoro(
                    # prefix_inactive='🌌   START',
                    # prefix_active='🛸 ',
                    # prefix_break='🌴 ',
                    # prefix_long_break='🌴 ',
                    prefix_inactive=' start', # pomodoro
                    prefix_active='祥 ', # clock
                    prefix_break=' ', #  nf-fae-isle  
                    prefix_long_break=' ', #  nf-pom-long_pause
                    prefix_paused=' pause', #   nf-mdi-beach

                    color_inactive = '#6C6F93', #color16
                    color_active = '#CD84C8', #color5
                    color_break = '#94CF95', #color2
                    font='DroidSansMono Nerd Font',

                    length_pomodori=25,
                    length_short_break=5,
                    length_long_break=10,
                    ),
                # widget.PulseVolume(),
                # widget.Volume(),

                # widget.Prompt(),
                # widget.TextBox("default config", name="default"),
                # widget.Systray(),
                widget.TextBox(
                    "",
                    foreground="#6C6F93", #color16
                    fontsize=20,
                    ),
                widget.Clock(
                    # format='%I:%M %p %a',
                    fmt=" {}",
                    format='%I:%M:%S',
                    foreground="#6C6F93", #color16
                    ),
                # widget.QuickExit(),
                # widget.CurrentLayoutIcon(
                #     padding=10,
                #     scale=0.55,
                #     ),                
                widget.TextBox(
                    " ",
                    foreground="#6C6F93", #color16
                    fontsize=18,
                    ),
            ],
            background="#1A2026", #background0
            size=30,
            opacity=1.0,
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
floating_layout = layout.Floating(
    float_rules=[
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
    ],
    border_focus='#94CF95',
    border_normal='#6C6F93',
    border_width=2,
    )
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
# 🌌🔭👩‍🚀👩‍💻🛰️🚀🌠🪐🛸⌚⏰⏱️🎉📡🌴🏝️🏖️💜🟣🟪☂️🍇🦄💙🟦🔷🔹🔵🐦
