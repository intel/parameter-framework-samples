#
# This script is used in order to start recording with ALSA.
#

if [ ! $# == 2 ]; then
    echo "Two arguments needed:" 1>&2
    echo "  - AlsaCard and device : -hw:<card>,<device>" 1>&2
    echo "  - Record destination" 1>&2
    exit
fi

card=$1
file=$2

arecord -D$card -d 10 -f S16_LE -r 48000 -c 2 $file
