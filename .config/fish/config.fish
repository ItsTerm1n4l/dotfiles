set fish_greeting
alias cs "clear"
#export PATH=$HOME/.local/bin:$PATH

#alias nano="alacritty -e nano -x"
function fish_prompt
  # interactive user name @ host name, date/time in YYYY-mm-dd format and path
#  /home/pi/.config/openbox/polybar/scroll_spotify_status.sh 
  echo (set_color --bold blue) [(set_color normal)(set_color brgreen)(pwd)(set_color --bold blue)](set_color --bold blue)(_git_branch_name)(set_color normal)(set_color red)
  echo " ❯ "  
#﬌
end
#function fish_right_prompt
#  # interactive user name @ host name, date/time in YYYY-mm-dd format and path
#  echo (set_color blue) [(set_color green)(pwd)(set_color blue)](set_color blue)-[(set_color green)(date +%R)(set_color blue)]
#  echo -e "\n<<<"  #﬌
#end

#function reload_gtk_theme
#  set theme $(gsettings get org.gnome.desktop.interface gtk-theme)
#  gsettings set org.gnome.desktop.interface gtk-theme ''
#  sleep 1
#  gsettings set org.gnome.desktop.interface gtk-theme $theme
#end

#function fish_greeting
#    neofetch
#end

function _git_branch_name
set -l branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
if [ "$branch" != "" ]
echo -[(set_color normal)(set_color green)$branch(set_color --bold blue)](set_color normal)
    else 
echo ""
end
end
starship init fish | source
