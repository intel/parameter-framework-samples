# Asus T100 tutorial

This directory contains Asus T100 exemple for Baytrail CR devices.

## Asus T100 Environment setup:

This part is describing Asus T100 environement setup.

### UBUNTU Setup
This section is describing how to get Asus T100 under Ubuntu.

Several Wiki pages are present on the Web. You can find a way to have UBUNTU install at the next Loacation.

All the tests done under UBUNTU have been validation with UBUNTU 16.10 release amd64 destop release.

Kernel used for the test is 4.8 release without any patches. You can follow the next link for more detail:
  https://wiki.ubuntu.com/KernelTeam/GitKernelBuild


## PFW setup for native compilation:

### UBUNTU package install for compilation on board.
Boot the board and install the different package needed.
```
sudo apt-get install build-essential cmake vim
sudo apt-get install libasound2-dev libxml2-dev libasio-dev
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

The next tag have been used for the validation:
   - v3.2.6 for the Parameter Framework
   - v1.1.3 for the ALSA Plugin.

Compile the different modules on the File system with native compilation.


## Test on Board

Go to parameter-framework-samples folder.
Go to asus-t100-tutorial folder.
```
 # Use the path set during Cmake build of PFW core.
export LD_LIBRARY_PATH=/usr/local/lib

 # Start test plattform with XML confoiguration.
test-platform ./AudioParameterFramework.xml


 # Create Criterion
remote-process localhost 5001 createExclusiveSelectionCriterionFromStateList Mode Normal RingTone
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList RoutageState Configure Flow Path
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList OpenedCaptureRoutes DeepMedia HwCodec0IA Media
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList OpenedPlaybackRoutes DeepMedia HwCodec0IA Media
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList SelectedInputDevices Back Headset Main
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList SelectedOutputDevices Headphones Headset Ihf Hdmi
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList AudioSource Default Mic None
remote-process localhost 5001 createExclusiveSelectionCriterionFromStateList ScreenState Off On

 # Start remote-process and get some parameters
remote-process localhost 5001 start
remote-process localhost 5000 listParameters /Audio/sst
remote-process localhost 5000 help
```

Exemple for Speaker Playback (Ihf) on Media port.

```
 # Enable Tuning mode (just need once)
remote-process localhost 5000 setTuningMode on

 # Configure Codec
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/headphone/analog/volume 0 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/headphone/analog/switch_l 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/headphone/analog/switch_r 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/headphone/switch 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/speaker/analog/volume 31 31
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/speaker/analog/switch_l 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/speaker/analog/switch_r 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/speaker/boost 3
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/speaker/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/digital/volume/dac1 165 165
remote-process localhost 5000 setParameter /Audio/codec/rt5640/output/digital/volume/mono_dac 130 130
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/output_mixer/right/dac/r1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/output_mixer/left/dac/l1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/speaker_mixer/right/dac/1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/speaker_mixer/left/dac/1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/spout_mixer/left/spkvol/left/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/spout_mixer/left/spkvol/right/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/analog/hpout_mixer/dac1/switch 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/adc_mixer/right/stereo/1/source 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/adc_mixer/right/stereo/1/switch 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/adc_mixer/left/stereo/1/switch 0
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/dac_mixer/stereo/right/1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/dac_mixer/stereo/left/1/switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/inf/right/inf1_switch 1
remote-process localhost 5000 setParameter /Audio/codec/rt5640/mixer/digital/inf/left/inf1_switch 1


 # Configure SST (LPE DSP)
remote-process localhost 5000 setParameter /Audio/sst/pipe/pcm_regular/gain/level 0 0
remote-process localhost 5000 setParameter /Audio/sst/pipe/pcm0_in/gain/level 0 0
remote-process localhost 5000 setParameter /Audio/sst/pipe/codec_out/gain/level 0 0
remote-process localhost 5000 setParameter /Audio/sst/pipe/media_loop1/gain/level 0 0
remote-process localhost 5000 setParameter /Audio/sst/pipe/media_loop1/gain/switch 1
remote-process localhost 5000 setParameter /Audio/sst/main_mixer/codec_out/mix/pcm0 0
remote-process localhost 5000 setParameter /Audio/sst/main_mixer/codec_out/mix/media_loop1 1
remote-process localhost 5000 setParameter /Audio/sst/main_mixer/pcm1/mix/pcm0 1
remote-process localhost 5000 setParameter /Audio/sst/main_mixer/media_loop1/mix/pcm0 1
remote-process localhost 5000 setParameter /Audio/sst/media_mixer/media0/mix/regular 1
remote-process localhost 5000 setParameter /Audio/sst/media_mixer/media0/mix/deep 0
remote-process localhost 5000 setParameter /Audio/sst/interleaver/codec_out/slot0/source 1
remote-process localhost 5000 setParameter /Audio/sst/interleaver/codec_out/slot1/source 2
remote-process localhost 5000 setParameter /Audio/sst/pipe/pcm_regular/gain/switch 1
remote-process localhost 5000 setParameter /Audio/sst/pipe/pcm0_in/gain/switch 1
remote-process localhost 5000 setParameter /Audio/sst/pipe/codec_out/gain/switch 1


 # Test playback
aplay -Dplughw:0,0 test.wav
```

# List of criterions:
--------------------
```
ExclusiveCriterion  Mode                   :  Normal      RingTone
InclusiveCriterion  RoutageState           :  Configure   Flow          Path
InclusiveCriterion  OpenedCaptureRoutes    :  DeepMedia   HwCodec0IA    Media
InclusiveCriterion  OpenedPlaybackRoutes   :  DeepMedia   HwCodec0IA    Media    Hdmi
InclusiveCriterion  SelectedInputDevices   :  Back        Headset       Main
InclusiveCriterion  SelectedOutputDevices  :  Headphones  Headset       Ihf
InclusiveCriterion  AudioSource            :  Default     Mic           None
ExclusiveCriterion  ScreenState            :  Off         On
```

# TODO:
- Create different configuration for the Processing loop.
- Add all the pipeline supportted by the driver.

