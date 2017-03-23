
# clientSimulator for Intel NUC
This section is describing how to use clientSimulator tool for NUC device.

## Before starting
clientSimulator is a tool provided on top of Parameter ramework. Please refer to the next link [clientSimulator](https://github.com/01org/parameter-framework/tree/master/tools/clientSimulator) for more infroamtion about the different options.

## Before starting
Variables setting and packages
```
sudo apt-get install python3 m4
export LD_LIBRARY_PATH=/usr/local/lib
export PYTHONPATH=/usr/local/lib/python3/dist-packages
```

## Running client simulator and update XML setting from .pfw files
1) Run Parameter Framework client simulator Go to tools nuc-tutorial/clientSimulator folder :
```
pfClientSimulator.py ./scripts/nuc
```
Update `scripts/nuc/conf.json` to reflect the path

=> Script will run `test-platform` application.

2) Generate Wav file
For the test script we need to have some Wav file. A simple way can be to use siggen UBUNTU Package in order to generate one file.
```
sudo apt-get install siggen
signalgen -v -b 16 -t 10 -2 -A 30 -s 48000 -w noise.wav noise 2000
```
Please note that reference playback file is put inside 'scripts/t100/audio-test-scripts.json'. So feel free to update with your own Wav file.

3) Check status
```
/usr/local/bin/remote-process localhost 5000 status
```

4) Play with the differnet UCs part of clientSimulator.

