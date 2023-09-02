#!/bin/bash

playerctl -s --player=mpv,%any metadata --format "{{ duration(position) }}/{{ duration(mpris:length) }}" -F
