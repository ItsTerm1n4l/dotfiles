#!/usr/bin/env bash

## Heavily modified from Aditya Shakya <adi1090x@gmail.com> Archcraft-os Thank You!
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
##			made by @ItsTerm1n4l on github
## A script to get colours from the theme file & deploy it to polybar, alacritty, rofi, dunst and many othes.
##			Uses COLOUR
##################################################################
#                         STILL W.I.P 				 #
# IK The code is still messy but I am working on cleaning it up  #
#								 #
##################################################################

DIR="$HOME/.config"
xfce_term_path="$HOME/.config/xfce4/terminal"
## Current theme ---------------------------------------------#
source "$DIR"/splash/colourschemes/current.bash #Import colours
CUSTOMBG="$background" #$background	#Allows custom background colours to be set
TERMBG="$background"

Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: setthemes.sh [-t|p|b|h]"
   echo "options:"
   echo "  -h     Print this Help."
   echo "  -b     Set background colour eg. (setthemes.sh -b 151724)."
   echo "  -c     Set terminal background colour eg. (setthemes.sh -c 0d0f17)."
   echo
}

# Get the options
while getopts ":hb:c:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      b) # Optional backgrund colour
         CUSTOMBG=#${OPTARG};;
      c)# Optional terminal background colour
	 TERMBG=#${OPTARG};;
	    \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done


## Get colors
getcolours () {
	FOREGROUND="$foreground"
	BACKGROUND="$background" #$CUSTOMBG
	CURSOR="$cursor"
	BLACK="$color0"
	RED="$color1"
	GREEN="$color2"
	YELLOW="$color3"
	BLUE="$color4"
	MAGENTA="$color5"
	CYAN="$color6"
	WHITE="$color7"
	ALTBLACK="$color8"
	ALTRED="$color9"
	ALTGREEN="$color10"
	ALTYELLOW="$color11"
	ALTBLUE="$color12"
	ALTMAGENTA="$color13"
	ALTCYAN="$color14"
	ALTWHITE="$color15"
}

## Write polybar colors file with current theme colors
polybar_archcraft_colour () {
	cat > "$HOME"/.config/openbox/polybar/current/colors.ini <<- EOF	
	[color]
	FOREGROUND = ${FOREGROUND}
	BACKGROUND = ${BACKGROUND}
	BLACK = ${BLACK}
	RED = ${RED}
	GREEN = ${GREEN}
	YELLOW = ${YELLOW}
	BLUE = ${BLUE}
	MAGENTA = ${MAGENTA}
	CYAN = ${CYAN}
	WHITE = ${WHITE}
	ALTBLACK = ${ALTBLACK}
	ALTRED = ${ALTRED}
	ALTGREEN = ${ALTGREEN}
	ALTYELLOW = ${ALTYELLOW}
	ALTBLUE = ${ALTBLUE}
	ALTMAGENTA = ${ALTMAGENTA}
	ALTCYAN = ${ALTCYAN}
	ALTWHITE = ${ALTWHITE}
	EOF
}

## Write alacritty colors.yml file with current theme colors
alacritty_colour () {
	cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
		## Colors configuration
		colors:
		  # Default colors
		  primary:
		    background: '${TERMBG}'
		    foreground: '${FOREGROUND}'
		  # Normal colors
		  normal:
		    black:   '${BLACK}'
		    red:     '${RED}'
		    green:   '${GREEN}'
		    yellow:  '${YELLOW}'
		    blue:    '${BLUE}'
		    magenta: '${MAGENTA}'
		    cyan:    '${CYAN}'
		    white:   '${WHITE}'
		  # Bright colors
		  bright:
		    black:   '${ALTBLACK}'
		    red:     '${ALTRED}'
		    green:   '${ALTGREEN}'
		    yellow:  '${ALTYELLOW}'
		    blue:    '${ALTBLUE}'
		    magenta: '${ALTMAGENTA}'
		    cyan:    '${ALTCYAN}'
		    white:   '${ALTWHITE}'
	_EOF_
}




## Write rofi colors.rasi file with current theme colors
rofi_colour () {
									#trying to be cross compatible with Aditya Shakya's Archcraft-os
	cat > "$DIR"/polybar/docky/scripts/rofi/colors.rasi <<- _EOF_	
	/* colors */
	* {
	    background:			${BACKGROUND}FF;
	    foreground:			${FOREGROUND}FF;
	    accent:			${BLUE}FF;
	    selection:			${BLUE}33;
	    al:				#00000000;
	    bar:			${BACKGROUND}FF;
	    urgent:				${RED};
	    on:					${GREEN};
	    off:				${RED};
	}
	_EOF_
}

## Write dunstrc file with current theme colors
dunst_colour () {
	sed -i '/urgency_low/Q' "$HOME"/.config/dunst/dunstrc
	cat > "$HOME"/.config/dunst/dunstrc <<- _EOF_
	[global]
	corner_radius = 8
	monitor = 0
	follow = mouse
	width = 350
	height = 80
	origin = top-right
	offset = 10x48
	indicate_hidden = yes
	shrink = no
	separator_color = "${BACKGROUND}"
	separator_height = 4
	line_height = 4
	padding = 15
	horizontal_padding = 15
	frame_width = 6
	sort = no
	idle_threshold = 120
	font = JetBrains Mono 10
	markup = full
	format = %s\n%b
	alignment = left
	show_age_threshold = 60
	word_wrap = yes
	ignore_newline = no
	stack_duplicates = false
	hide_duplicate_count = yes
	show_indicators = no
	icon_position = left
	max_icon_size = 48
	sticky_history = yes
	history_length = 20
	browser = chromium --new-tab
	always_run_script = true
	title = Dunst
	class = Dunst

	[urgency_low]
	timeout = 2
	background = "${BACKGROUND}"
	foreground = "${FOREGROUND}"
	frame_color = "${BLUE}"

	[urgency_normal]
	timeout = 5
	background = "${BACKGROUND}"
	foreground = "${FOREGROUND}"
	frame_color = "${BLUE}"

	[urgency_critical]
	timeout = 0
	background = "${BACKGROUND}"
	foreground = "${FOREGROUND}"
	frame_color = "${RED}"
	_EOF_
}

xfce_terminal_colour () {
	sed -i -e "s/ColorForeground=.*/ColorForeground=${FOREGROUND}/g"	${xfce_term_path}/terminalrc
	sed -i -e "s/ColorBackground=.*/ColorBackground=${BACKGROUND}/g"	${xfce_term_path}/terminalrc
	sed -i -e "s/ColorCursor=.*/ColorCursor=${FOREGROUND}/g" 			${xfce_term_path}/terminalrc
	sed -i -e "s/ColorPalette=.*/ColorPalette=${BLACK};${RED};${GREEN};${YELLOW};${BLUE};${MAGENTA};${CYAN};${WHITE};${ALTBLACK};${ALTRED};${ALTGREEN};${ALTYELLOW};${ALTBLUE};${ALTMAGENTA};${ALTCYAN};${ALTWHITE}/g" ${xfce_term_path}/terminalrc
}


foot_colour () {
	cat > "$HOME"/.config/foot/colors.ini <<- _EOF_
	[colors]
	alpha=0.97
	foreground=eeeeee
	background=${BACKGROUND//#}
	regular0=${BLACK//#}  # black
	regular1=${RED//#}  # red
	regular2=${GREEN//#}  # green
	regular3=${YELLOW//#} # yellow
	regular4=${BLUE//#} # blue
	regular5=${MAGENTA//#}  # magenta
	regular6=${CYAN//#}  # cyan
	regular7=${WHITE//#}  # white
	bright0=${BLACK//#}   # bright black
	bright1=${RED//#}   # bright red
	bright2=${GREEN//#}   # bright green
	bright3=${YELLOW//#}   # bright yellow
	bright4=${BLUE//#}   # bright blue
	bright5=${MAGENTA//#}   # bright magenta
	bright6=${CYAN//#}   # bright cyan
	bright7=${WHITE//#}   # bright white
_EOF_

}
polybar_colour () {
    cat > "$HOME"/.config/polybar/splash/colors.ini <<- _EOF_
	[color]
	background = ${BACKGROUND}
	foreground = ${FOREGROUND}
	foreground-alt = #656565
	module-fg = ${BACKGROUND}
	primary = ${BLUE}
	secondary = ${RED}
	alternate = ${GREEN}
	_EOF_
    polybar-msg cmd restart		#Restart Polybar
}

fish_colour () {
    cat > "$HOME"/.config/fish/themes/splash.theme <<- _EOF_
	fish_color_normal ${FOREGROUND//#}
	fish_color_command ${BLUE//#}
	fish_color_param eebebe
	fish_color_keyword ${RED//#}
	fish_color_quote ${GREEN//#}
	fish_color_redirection ${MAGENTA//#}
	fish_color_end ef9f76
	fish_color_comment ${ALTBLACK//#}
	fish_color_error ${RED//#}
	fish_color_gray 737994
	fish_color_selection --background=414559
	fish_color_search_match --background=414559
	fish_color_operator ${MAGENTA//#}
	fish_color_escape ea999c
	fish_color_autosuggestion ${BLACK//#}
	fish_color_cancel ${RED//#}
	fish_color_cwd ${YELLOW//#}
	fish_color_user ${CYAN//#}
	fish_color_host ${BLUE//#}
	fish_color_host_remote ${GREEN//#}
	fish_color_status ${RED//#}
	fish_pager_color_progress 737994
	fish_pager_color_prefix ${MAGENTA//#}
	fish_pager_color_completion ${FOREGROUND//#}
	fish_pager_color_description 737994
	_EOF_
#    fish --command="echo "y" | fish_config theme save "splash"" #Save the colorscheme for fish
}
vim_colour () {
	cat > "$HOME"/.local/share/nvim/plugged/splash.vim/autoload/splash.vim <<- _EOF_

let s:overrides = get(g:, "onedark_color_overrides", {})

let s:colors = {
       \ "red": get(s:overrides, "red", { "gui": "${RED}", "cterm": "204", "cterm16": "1" }),
       \ "dark_red": get(s:overrides, "dark_red", { "gui": "${ALTRED}", "cterm": "196", "cterm16": "9" }),
       \ "green": get(s:overrides, "green", { "gui": "${GREEN}", "cterm": "114", "cterm16": "2" }),
       \ "yellow": get(s:overrides, "yellow", { "gui": "${YELLOW}", "cterm": "180", "cterm16": "3" }),
       \ "dark_yellow": get(s:overrides, "dark_yellow", { "gui": "${ALTYELLOW}", "cterm": "173", "cterm16": "11" }),
       \ "blue": get(s:overrides, "blue", { "gui": "${BLUE}", "cterm": "39", "cterm16": "4" }),
       \ "purple": get(s:overrides, "purple", { "gui": "${MAGENTA}", "cterm": "170", "cterm16": "5" }),
       \ "cyan": get(s:overrides, "cyan", { "gui": "${CYAN}", "cterm": "38", "cterm16": "6" }),
       \ "white": get(s:overrides, "white", { "gui": "${WHITE}", "cterm": "145", "cterm16": "15" }),
       \ "black": get(s:overrides, "black", { "gui": "${BLACK}", "cterm": "235", "cterm16": "0" }),
       \ "foreground": get(s:overrides, "foreground", { "gui": "${FOREGROUND}", "cterm": "145", "cterm16": "NONE" }),
       \ "background": get(s:overrides, "background", { "gui": "${BACKGROUND}", "cterm": "235", "cterm16": "NONE" }),
       \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#5C6370", "cterm": "59", "cterm16": "7" }),
       \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "8" }),
       \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "0" }),
       \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
       \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#151724", "cterm": "237", "cterm16": "7" }),
       \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "7" }),
       \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#3E4452", "cterm": "59", "cterm16": "7" }),
      \}

function! onedark#GetColors()
  return s:colors
endfunction
_EOF_
}


lualine_colour () {
	cat > "$HOME"/.local/share/nvim/plugged/lualine.nvim/lua/lualine/themes/splash.lua <<- _EOF_
-- Copyright (c) 2021 Jnhtr
-- MIT license, see LICENSE for more details.
-- stylua: ignore
local colors = {
  black        = '${BLACK}',
  white        = '${WHITE}',
  red          = '${RED}',
  green        = '${GREEN}',
  blue         = '${BLUE}',
  yellow       = '${YELLOW}',
  gray         = '${ALTWHITE}',
  darkgray     = '${BLACK}', 
  lightgray    = '${ALTBLACK}',  -- #1e2133
  inactivegray = '#1C1E26',  -- #1C1E26
}

return {
  normal = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  insert = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  replace = {
    a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  command = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.inactivegray, fg = colors.lightgray, gui = 'bold' },
    b = { bg = colors.inactivegray, fg = colors.lightgray },
    c = { bg = colors.inactivegray, fg = colors.lightgray },
  },
}
_EOF_
}


## Execute functions and run main 
main () {		#Will add more apps
	getcolours
#	rofi_colour
	xfce_terminal_colour
#	polybar_colour
	fish_colour
#    vim_colour
#    lualine_colour
#	foot_colour
#	polybar_archcraft_colour
#	alacritty_colour
#	dunst_colour
}
main

