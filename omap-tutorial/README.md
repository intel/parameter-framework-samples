# OMAP tutorial

This directory contains OMAP exemple for PandaBoardES and Pand5-uevm board.

## OMAP Environment setup:

This part is describing OMAP environement setup for PANDA board.

### Bootloader and Kernel
This section is describing how to build the different bootloader and kernel components.

- u-boot:
--------
For u-boot the upstream mainline is supporting OMAP devices. A simple patch is needed in order to ensure the configuration of the OMAP ABE DPLL to use the SYSCLK for the ABE DPLL.

```
git clone git://git.denx.de/u-boot.git
```

Add the #define CONFIG_SYS_OMAP_ABE_SYSCK inside ./include/configs/omap4_panda.h
```
make CROSS_COMPILE=arm-none-linux-gnueabi- omap4_panda_config
make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm
```
=> Generation `MLO` and `u-boot.img` for boot partition

- kernel:
--------
As OMAP ABE code is not upstream the next tree is sharing a Kernel image based on 3.14 kernel. This image is enabling ABE and still need some improvement for stability.

```
git clone git://gitorious.org/omap-audio/linux-audio.git
git checkout origin/sgc/topic/pfw_omap
make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm omap2plus_defconfig
make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm uImage -j5
make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm dtbs
cd arch/arm/boot
mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d zImage uImage
```
=> Copy uImage and `omap4-panda-es.dtb` on the boot partition


### OMAP Audio BackEnd Firmware generation
This section is describing how to generated the OMAP4+  ABE FW and the ASoC-DFW header for Audio Firmware binaries.

#### OMAP AESS/ABE FW:

* OMAP ABE tool:

This tool is used in order to add some FW binary data on top of the firmware. The kernel driver is usem them in order to get all the different FW address for the audio cluster and port configuration.

```
git clone git://gitorious.org/omap-audio/abefw.git
./autogen.sh
./configure --with-linux-dir=/path/to/linux.git
make
sudo make install
./scripts/abe_tool.h 009590
```

#### ASoC-DFW tool:
* ASoC-DFW tool

This tool is used to create all the binary data for the mixer controls, DAPM graph for the Audio driver.

```
git clone git://gitorious.org/omap-audio/asoc-fw.git
git checkout origin/sgc/topic/pfw_omap
./autogen.sh
./configure --with-linux-dir=/path/to/linux.git --enable-omap4
make
sudo make install
./scripts/abegen.sh
```
=> generate `omap4_abe_new` FW file. To be copy inside `/lib/firmware/omap_aess-adfw.bin`

### File System generation

The PFW test has been done with UBUNTU Core File System or Poky minimal image..

#### UBUNTU File System:
Download ubuntu core FS.
=> Untar the FS on the File system partition

* Remove Root password
```
sudo gedit /media/rootfs/etc/shadow
```
Remove the star `*` after `root:` inside the file
```
 root::...
```

* Update the console port

Create new file: /etc/init/serial.conf
```
sudo nano /media/rootfs/etc/init/serial.conf
```
Content
```
start on stopped rc RUNLEVEL=[2345]
stop on runlevel [!2345]

respawn
exec /sbin/getty 115200 ttyO2
```

## PFW setup for native compilation:

### UBUNTU package install for compilation on board.

Boot the board and install the different package needed.
```
sudo apt-get install build-essential cmake vim
sudo apt-get install libasound2-dev libxml2-dev
```

### Repository to Clone:
Create a folder intel
Clone the different git tree for PFW.
```
git clone http://github.com/01org/parameter-framework.git
git clone http://github.com/01org/parameter-framework-plugins-alsa.git
git clone http://github.com/01org/parameter-framework-samples.git
```

### Parameter Framework:
Follow the README in order to compile PFW and the plugin.

Compile the different modules on the File system with native compilation.


## Test on Board
Go to parameter-framework-samples folder.
Go to omap-tutorial folder.
```
 # Use the path set during Cmake build of PFW core.
export LD_LIBRARY_PATH=/usr/local/lib

test-platform ./PandaBoardES.xml
remote-process localhost 5001 start
remote-process localhost 5000 listParameters /Audio
remote-process localhost 5000 help
```
Exemple for Headset Playback on Media port.
```
 # Enable Tuning mode (just need once)
remote-process localhost 5000 setTuningMode on
 # Configure Codec
remote-process localhost 5000 setParameter /Audio/omapabe/twl6040/output/headset/volume 12
remote-process localhost 5000 setParameter /Audio/omapabe/twl6040/output/headset/enable/right hs_dac
remote-process localhost 5000 setParameter /Audio/omapabe/twl6040/output/headset/enable/left hs_dac
 # Configure ABE/AESS
remote-process localhost 5000 setParameter /Audio/omapabe/abe/output/headset/dl1/media_playback 120
remote-process localhost 5000 setParameter /Audio/omapabe/abe/output/headset/dl1/mixer_media 1
remote-process localhost 5000 setParameter /Audio/omapabe/abe/output/headset/sdt_dl 1
remote-process localhost 5000 setParameter /Audio/omapabe/abe/output/headset/sdt_dl_volume/volume 120
remote-process localhost 5000 setParameter /Audio/omapabe/abe/output/pdm 1
 # Test playback
aplay -Dplughw:0,0 test.wav
```

# TODO:

Create some PFW file for the setting of the different Path.
For Pandaboard:
 - Modem/VoiceCall is not supported
 - Earpiece and IHF are not supported
 - DMICs are not supported

Capture ports:
 - Media => MM_UL2
 - MultiChannel => MM_UL2
 - Voice => VX_UL
 - Modem => VX_UL (dummy FE)
Playback ports:
 - Media => MM_DL
 - Tones => TONES_DL
 - Voice => VX_DL
 - Modem => VX_DL (dummy FE)
 - DeepMedia => PingPong port Low Power.


List of criterions for OMAP ABE:
-------------------------------
```
ExclusiveCriterion  Mode                   :  InCsvCall         InVoipCall       Normal
InclusiveCriterion  RoutageState           :  Configure         Flow             Path
InclusiveCriterion  ClosingCaptureRoutes   :  Media     Modem     Voice     MultiChannel
InclusiveCriterion  ClosingPlaybackRoutes  :  Media     Modem     Voice     Tones        DeepMedia
InclusiveCriterion  OpenedCaptureRoutes    :  Media     Modem     Voice     MultiChannel
InclusiveCriterion  OpenedPlaybackRoutes   :  Media     Modem     Voice     Tones        DeepMedia
InclusiveCriterion  SelectedInputDevice    :  SubMic             Headset    MainMic    Dmic1    Dmic2     Dmic1
InclusiveCriterion  SelectedOutputDevice   :  Earpiece   Headset        Ihf
InclusiveCriterion  AudioSource            :  Default          Mic              None              VoiceCall  VoiceCommunication  VoiceDownlink  VoiceUplink
ExclusiveCriterion  BandType               :  NB                SuperWB          Unknown          WB
ExclusiveCriterion  ScreenState            :  Off               On
```

Link:
====
http://www.omappedia.com/wiki/Audio_Drive_Arch

