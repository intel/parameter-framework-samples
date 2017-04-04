# Intel NUC SystemDesigner tutorial

This directory contains SystemDesigner configuration files for Asus T100

## SystemDesigner setup:

SystemDesigner can be downloaded from the next link:
  https://01.org/parameter-framework/companion-tools

Please note that you will need to install openjdk-8 in order to run it. After the untar of the archive please do a 'chmod +x system_designer' in order to be able to run the tool.
For getting Help on the tool you can run the tool and go to Help menu in order to get more information.

System Designer can allow you to develop custom plugin for Audio Tuning of some Acoustic processiong. Current sample is based on Asus T100 DSP topology. Only tuning part is visible under System Designer. The routing is not visible.

### how to start
Before starting System Designer you will need to get one instance of Parameter Framework up and runing. In order to do that the best solution is to run ClientSimulator.
After the instance of clientSimulator is up and runing you can connect SystemDesigner to the `test-platorm`.
```
Run system designer
Inside Device Manager Right click on Ethernet and select Add new device
Enter localhost IP (127.0.0.1) Port is 5000 and select tuning_topology folder for Offline layout
A new item is visible inside under the Ethernet. Right click on it and select on Connect.
Now System Designer will show you the different path of the Audio system
```

### Editor Mode

If you want to customize the topology file you can run System Designer with the next paramter. It will open the topology in edition mode in order to be able to modify it.
```
./system_designer -editorMode
```

