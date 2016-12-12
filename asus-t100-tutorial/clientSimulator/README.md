
# clientSimulator for Asus T100

## Before starting
Variables setting and packages
```
sudo apt-get install python3 m4
export LD_LIBRARY_PATH=/usr/local/lib
```

## Running client simulator and update XML setting from .pfw files
1) Run Parameter Framework client simulator Go to tools asus-t100-tutorial/clientSimulator folder :
```
<PATH to Paremeter Framework>/tools/clientSimulator/pfClientSimulator.py ./scripts/t100
```
Update `scripts/t100/conf.json` to reflect the path

=> Script will run `test-platform` application.

2) Check status
```
/usr/local/bin/remote-process localhost 5000 status
```

3) Generate Routing from .pfw configuration files
For the Rooting you can use some .pfw file in order to avoid to directly update the XML file.
```
 gen_xml.sh
```

4) Generate Wav file
For the test script we need to have some Wav file. A simple way can be to use siggen UBUNTU Package in order to generate one file.
```
sudo apt-get install siggen
signalgen -v -b 16 -t 10 -2 -A 30 -s 48000 -w noise.wav noise 2000
```
Please note that reference playback file is put inside 'scripts/t100/audio-test-scripts.json'. So feel free to update with your own Wav file.

5) Restart client simulator and check UCs.
