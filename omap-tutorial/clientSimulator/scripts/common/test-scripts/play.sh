#
# This script is used in order to start playback with ALSA.
#

if [ ! $# == 2 ]; then
    echo "Two arguments needed:" 1>&2
    echo "  - AlsaCard and device : -hw:<card>,<device>" 1>&2
    echo "  - File to play" 1>&2
    exit
fi

alsaCardDevice=$1
file=$2

aplay -D$alsaCardDevice $file
