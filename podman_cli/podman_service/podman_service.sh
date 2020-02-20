#!/usr/bin/env sh

# podman_service.sh demo script.
# This script will demonstrate the usage
# of the podman apiv2
# from docker client using unix socket.
# Requires the Docker and Podman packages to be installed.

 
# Setting up some colors for helping read the demo output.
# Comment out any of the below to turn off that color.
bold=$(tput bold)
cyan=$(tput setaf 6)
red=$(tput setaf 1)
reset=$(tput sgr0)

read_color() {
    read -p "${bold}$1${reset}"
}

read_red_color() {
    read -p "${bold}${red}$1${reset}"
}

echo_color() {
    echo "${cyan}$1${reset}"
}


intro() {
    read -p "Podman service demo!"
    echo
}


docker_via_podman_socket() {

    echo_color "Create podman socket"
    echo
    read_color "$ podman system service --timeout 0 unix:///tmp/podman.sock &"
    rm -rf /tmp/podman.sock
    podman system service --timeout 0 unix:///tmp/podman.sock &
    echo
    
    echo_color "Use socket in docket"
    echo
    read_color "$ export DOCKER_HOST='unix:///tmp/podman.sock'"
    export DOCKER_HOST='unix:///tmp/podman.sock'
    echo
    
    echo_color "Run docker commands"
    echo
    read_color "$ docker images"
    docker images
    echo
    read_color "$ podman images"
    podman images
    echo
    read_color "$ docker ps"
    docker ps
    echo
    read_color "$ podman ps"
    podman ps
    echo
    echo
    read -p "Enter to continue"
    kill %1
    clear
}

intro

docker_via_podman_socket

read -p "End of Demo!!!"
echo
echo "Thank you!"
