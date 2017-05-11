
# clientSimulator for PandaBoard

## Before starting
1) Variables setting and packages
```
sudo apt-get install python3 m4
export LD_LIBRARY_PATH=/usr/local/lib
```
2) Delta inside PFW core for scripts under UBUNTU
```
diff --git a/tools/xmlGenerator/lightRoutingUpdate.sh b/tools/xmlGenerator/lightRoutingUpdate.sh
index 4bde78f..e084d50 100755
--- a/tools/xmlGenerator/lightRoutingUpdate.sh
+++ b/tools/xmlGenerator/lightRoutingUpdate.sh
@@ -35,12 +35,12 @@

 set -eu -o pipefail

-adbShell="adb shell"
+adbShell=" "
 parameter="$adbShell $parameterCommandAccess"

-tmpfile="/tmp/pfw_commands"
-target_tmpfile="/data/pfw_commands"
+tmpfile="/home/lab/external/panda/tmp/pfw_commands"
+target_tmpfile="/home/lab/external/panda/data/pfw_commands"


 adbShellForward () {
@@ -48,7 +48,7 @@ adbShellForward () {
     echo 'echo $?; exit' >> "$1"

     # Send commands
-    adb push "$1" "$target_tmpfile"
+    cp "$1" "$target_tmpfile"
     $adbShell chmod 700 "$target_tmpfile"

     $adbShell "$target_tmpfile" |
```

## Running MiddleWare simulator and update XML setting from .pfw files
1) Run Parameter Framework client simulator Go to tools omap-tutorial folder :
```
<PATH to Paremeter Framework>/tools/clientSimulator/pfClientSimulator.py ./clientSimulator/scripts/panda
```
Update `scripts/panda/conf.json` to reflect the path

=> Script will run `test-platform` application.

2) Check status
```
/usr/local/bin/remote-process localhost 5000 status
```

3) Generate Routing from audio_hal folder
```
/usr/local/bin/remote-process localhost 5000 setTuningMode on
/usr/local/bin/remote-process localhost 5000 deleteAllDomains
~/intel/parameter-framework/tools/xmlGenerator/lightRoutingUpdate.sh routing_twl6040.pfw  routing_omapabe.pfw
```

4) Save XML for the next Setting
```
/usr/local/bin/remote-process localhost 5000 exportDomainsWithSettingsXML /home/ubuntu/test.xml
cp /home/ubuntu/test.xml ~/intel/parameter-framework-samples/omap-tutorial/Settings/Audio/AudioConfigurableDomains.xml
```

5) Restart MiddleWare simulator and check UCs.


