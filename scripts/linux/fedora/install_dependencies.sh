#!/bin/sh

. ../common.sh

exit_if_not_sudo

## thanks to Claudio for details on packages to install on fedora
yum install freeglut-devel alsa-lib-devel libXmu-devel libXxf86vm-devel gcc-c++ libraw1394-devel gstreamer1-devel gstreamer1-plugins-base-devel libudev-devel libtheora-devel libvorbis-devel openal-soft-devel libsndfile-devel python-lxml glew-devel flac-devel freeimage-devel cairo-devel pulseaudio-libs-devel openssl-devel libusbx-devel gtk2-devel libXrandr-devel libXi-devel opencv-devel libX11-devel assimp-devel rtaudio-devel boost boost-devel

exit_code=$?
if [ $exit_code != 0 ]; then
    echo error installing packages, there could be an error with your internet connection
    exit $exit_code
fi

recompile_poco_if_gcc_gt_4
