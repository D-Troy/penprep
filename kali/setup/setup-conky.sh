#!/bin/bash
## =============================================================================
# File:     setup-conky.sh
#
# Author:   Cashiuus
# Created:  01/27/2016          Revised:    13-MAY-2016
#
# Purpose:  Setup conky monitor dashboard on desktop with pre-configured style
#
#
# Source Code of Conky Variables: https://github.com/brndnmtthws/conky/blob/master/doc/variables.xml
# Ref: http://forums.opensuse.org/english/get-technical-help-here/how-faq-forums/unreviewed-how-faq/464737-easy-configuring-conky-conkyconf.html
## =============================================================================
__version__="1.0"
__author__="Cashiuus"
## ========[ TEXT COLORS ]================= ##
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
RED="\033[01;31m"      # Issues/Errors
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal
## =========[ CONSTANTS ]================ ##
USE_OLD_CONKY=0
OLD_CONKY_CONF="${HOME}/.conkyrc"
NEW_CONKY_CONF="${HOME}/.config/conky/conky.conf"
# =============================[ Install & Setup ]================================ #

apt-get -y install conky


# Conky < 1.9 uses old config style we are used to using
# Conky >= 1.10 uses new Lua-based configuration style

if [[ ${USE_OLD_CONKY} -eq 1 ]]; then
  # If we've set this variable to 1, we want old conky.
  echo -e "${GREEN}[*]${RESET} Performing setup of OLD version Conky..."
  if [[ ! -e "${OLD_CONKY_CONF}" ]]; then
    cat <<EOF > "${OLD_CONKY_CONF}"
background yes
gap_x 12
gap_y 35

# -----[ Window Size & Position ]----- #
alignment bottom_right

border_width 1
draw_borders no
draw_outline no
draw_graph_borders yes
draw_shades yes

uppercase no

use_xft yes
xftalpha 0.9
xftfont DejaVu Sans Mono:size=8
override_utf8_locale no

default_color white

own_window yes
own_window_type normal
own_window_transparent no
own_window_colour black
own_window_argb_visual yes
own_window_argb_value 50
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager

double_buffer yes
no_buffers yes

out_to_console no
out_to_stderr no
extra_newline no

use_spacer none
show_graph_scale no
show_graph_range no

# --[ PROCESS CONFIGURATIONS ]-- #
update_interval 2.0
total_run_times 0
cpu_avg_samples 2
net_avg_samples 2

# --[ TEXT LAYOUT ]-- #
TEXT
\${color green}SYSTEM: \$nodename (\$machine)\${hr 1}\${color}
Uptime: \$alignr\$uptime
CPU: \${alignr}\${freq_g} GHz
Processes: \${alignr}\$processes (\$running_processes running)
Load: \${alignr}\$loadavg
\${cpugraph 20}
Ram \${alignr}\$mem / \$memmax (\$memperc%)
\${membar 4}
Swap \${alignr}\$swap / \$swapmax (\$swapperc%)
\${swapbar 4}
Highest CPU \${alignr} CPU% MEM%
\${top name 1}\$alignr\${top cpu 1}\${top mem 1}

Highest MEM \${alignr} CPU% MEM%
\${top_mem name 1}\${alignr}\${top_mem cpu 1}\${top_mem mem 1}

\${color green}FILESYSTEMS\${hr 1}\${color}
Root \${alignc}\${fs_used /} / \${fs_size /}\${alignr}\${fs_used_perc /}%
\${fs_bar 4 /}+

\${color yellow}NETWORK \${hr 1}\${color}
\${if_up eth0}\${color white}LAN: eth0 (\${addr eth0})
Down\${color}: \${downspeed eth0}KB/s \${color white}Up\${color}: \${upspeed eth0}KB/s
\${downspeedgraph eth0 10,80 99cc33 006600} \${alignr}\${upspeedgraph eth0 10,80 ffcc00 ff0000}
\${endif}

\${color green}CUSTOM ALIASES \${hr 1}\${color}
bashload \${alignr}update-kali
myip \${alignr}timer
open <file> \${alignr}openports
workon <project> \${alignr}webserv
EOF
  fi
else
  # TODO: New conky method
  filedir="${HOME}/.config/conky"
  [[ ! -d "${filedir}" ]] && mkdir -p "${filedir}"
  cat <<EOF > "${NEW_CONKY_CONF}"
conky.config = {
    background = false,
    gap_x = 12,
    gap_y = 35,
    alignment = 'bottom_right',

    default_color = 'white',
    border_width = 1,
    draw_borders = false,
    draw_outline = false,
    draw_graph_borders = true,
    draw_shades = true,

    use_xft = true,
    xftalpha = 0.9,
    font = 'DejaVu Sans Mono:size=8',
    override_utf8_locale = false,
    uppercase = false,

    own_window = true,
    own_window_type = 'normal',
    own_window_transparent = false,
    own_window_colour = 'black',
    own_window_argb_visual = true,
    own_window_argb_value = 50,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

    double_buffer = true,
    no_buffers = true,

    out_to_console = false,
    out_to_stderr = false,
    extra_newline = false,

    use_spacer = 'none',
    show_graph_scale = false,
    show_graph_range = false,

    update_interval = 2.0,
    total_run_times = 0,
    cpu_avg_samples = 2,
    net_avg_samples = 2,
};

conky.text = [[
\${color green}SYSTEM: \$nodename (\$machine)\${hr 1}\${color}
Uptime: \$alignr\$uptime
CPU: \${alignr}\${freq_g} GHz
Processes: \${alignr}\$processes (\$running_processes running)
Load: \${alignr}\$loadavg
\${cpugraph 20}
Ram \${alignr}\$mem / \$memmax (\$memperc%)
\${membar 4}
Swap \${alignr}\$swap / \$swapmax (\$swapperc%)
\${swapbar 4}
Highest CPU \${alignr} CPU% MEM%
\${top name 1}\$alignr\${top cpu 1}\${top mem 1}

Highest MEM \${alignr} CPU% MEM%
\${top_mem name 1}\${alignr}\${top_mem cpu 1}\${top_mem mem 1}

\${color green}FILESYSTEMS\${hr 1}\${color}
Root \${alignc}\${fs_used /} / \${fs_size /}\${alignr}\${fs_used_perc /}%
\${fs_bar 4 /}+

\${color yellow}NETWORK \${hr 1}\${color}
\${if_up eth0}\${color white}LAN: eth0 (\${addr eth0})
Down\${color}: \${downspeed eth0}KB/s \${color white}Up\${color}: \${upspeed eth0}KB/s
\${downspeedgraph eth0 10,80 99cc33 006600} \${alignr}\${upspeedgraph eth0 10,80 ffcc00 ff0000}
\${endif}

\${color green}CUSTOM ALIASES \${hr 1}\${color}
bashload \${alignr}update-kali
myip \${alignr}timer
open <file> \${alignr}openports
workon <project> \${alignr}webserv
]]
EOF

fi


# =============================[ Custom Scripts ]================================ #

file="/usr/local/bin/conky-start"
echo -e "${GREEN}[*] ${RESET}Adding conky-start script"
cat <<EOF > "${file}"
#!/bin/bash

$(which timeout) 10 $(which killall) -9 -q -w conky
$(which sleep) 20s
$(which conky) &
EOF
chmod -f 0500 "${file}"
bash /usr/local/bin/conky-start >/dev/null 2>&1 &


mkdir -p "${HOME}/.config/autostart"
file="${HOME}/.config/autostart/conkyscript.desktop"
echo -e "${GREEN}[*] ${RESET}Adding conky-autostart file"
cat <<EOF > "${file}"
[Desktop Entry]
Name=conky
Exec=/usr/local/bin/conky-start
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Type=Application
Comment=
EOF


# =========[ Keyboard Shortcut (Alt+F2) to 'conky-refresh' ]======= #
#file="${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
#if [[ -e "${file}" ]]; then
    #grep -q '<property name="&lt;Primary&gt;r" type="string" value="/usr/local/bin/conky-start"/>' "${file}" || sed -i 's#<property name=\&lt;Alt\&gt;F2" type="string" value="xfrun4"/>#<property name="\&lt;Alt\&gt;F2" type="string" value="xfrun4"/>\n        <property name="\&lt;Primary\&gt;r" type="string" value="/usr/local/bin/conky-refresh"/>#' "${file}"
#fi

# ===========================[ Conky with GNU Screen ]=============================== #
### TODO: Conky 1.10 and later uses Lua-based configurations
### TODO: It is possible to create a configuration to show basic specs at the bottom of a screen console session
# Info: https://github.com/brndnmtthws/conky/wiki/ConkyAndGnuScreen

#apt-get -y install screen

# Check if conky was compiled with X11 support by parsing output of this command
#conky -v | grep "X11"




# End of script
bash /usr/local/bin/conky-start >/dev/null 2>&1 &
echo -e "${GREEN}[*]${RESET} Conky install complete!"

# ============================ [ NOTES ] ================================= #
#
# Default config file path: $HOME/.conkyrc
# System config file: /etc/conky/conky.conf
# Package library path: /usr/lib/conky

#Usage: conky [OPTION]...
#conky is a system monitor that renders text on desktop or to own transparent
#window. Command line options will override configurations defined in config
#file.
#   -v, --version             version
#   -q, --quiet               quiet mode
#   -D, --debug               increase debugging output, ie. -DD for more debugging
#   -c, --config=FILE         config file to load
#   -C, --print-config        print the builtin default config to stdout
#                             e.g. 'conky -C > ~/.conkyrc' will create a new default config
#   -d, --daemonize           daemonize, fork to background
#   -h, --help                help
#   -a, --alignment=ALIGNMENT text alignment on screen, {top,bottom,middle}_{left,right,middle}
#   -f, --font=FONT           font to use
#   -X, --display=DISPLAY     X11 display to use
#   -o, --own-window          create own window to draw
#   -b, --double-buffer       double buffer (prevents flickering)
#   -w, --window-id=WIN_ID    window id to draw
#   -x X                      x position
#   -y Y                      y position
#   -t, --text=TEXT           text to render, remember single quotes, like -t '$uptime'
#   -u, --interval=SECS       update interval
#   -i COUNT                  number of times to update conky (and quit)
#   -p, --pause=SECS          pause for SECS seconds at startup before doing anything
