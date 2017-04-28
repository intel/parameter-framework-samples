# Intel NUC tutorial

This directory contains Intel NUC sample for Skylake devices (NUC6i5SYH).

## Intel NUC Environment setup:

This part is describing Intel NUC environement setup.

### UBUNTU Setup
This section is describing how to get Intel NUC under Ubuntu.

Several Wiki pages are present on the Web. You can find a way to have UBUNTU install at the next Loacation.

All the tests done under UBUNTU have been validation with UBUNTU 17.04 release amd64 destop release.


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
   - v3.2.7 for the Parameter Framework
   - v1.1.3 for the ALSA Plugin.

Compile the different modules on the File system with native compilation.


## Test on Board

Go to parameter-framework-samples folder.
Go to nuc-tutorial folder.
```
 # Use the path set during Cmake build of PFW core.
export LD_LIBRARY_PATH=/usr/local/lib

 # Start test plattform with XML confoiguration.
test-platform ./AudioParameterFramework.xml


 # Create Criterion
remote-process localhost 5001 createExclusiveSelectionCriterionFromStateList Mode Normal
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList RoutageState Configure Flow Path
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList OpenedCaptureRoutes Media
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList OpenedPlaybackRoutes Media   Hdmi
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList SelectedInputDevices Headset
remote-process localhost 5001 createInclusiveSelectionCriterionFromStateList SelectedOutputDevices Headphones Headset AuxDigital
remote-process localhost 5001 createExclusiveSelectionCriterionFromStateList ScreenState Off On

 # Start remote-process and get some parameters
remote-process localhost 5001 start
remote-process localhost 5000 listParameters /Audio/alc283

remote-process localhost 5000 help
```

Exemple for Headset Playback on Media port.

```
 # Enable Tuning mode (just need once)
remote-process localhost 5000 setTuningMode on

 # Configure Codec
remote-process localhost 5000 setParameter /Audio/alc283/output/headset/switch 1 1
remote-process localhost 5000 setParameter /Audio/alc283/output/headset/volume 50 50


 # Test playback
aplay -Dplughw:0,0 test.wav
```

# List of criterions:
--------------------
```
ExclusiveCriterion  Mode                   :  Normal
InclusiveCriterion  RoutageState           :  Configure   Flow          Path
InclusiveCriterion  OpenedPlaybackRoutes   :  Media       Hdmi
InclusiveCriterion  OpenedCaptureRoutes    :  Media
InclusiveCriterion  SelectedInputDevices   :  Headset
InclusiveCriterion  SelectedOutputDevices  :  Headphones  Headset       AuxDigital
ExclusiveCriterion  ScreenState            :  Off         On
```

# TODO:
- Enable all HDMI outputs.
- Add all the mixers controls.

