#ClientSimulator CRITERIA TESTS AUDIO TESTS FILES README

##Project
Those files are tests vectors and configurations for Audio HAL.
They depend on the AudioCriteria.txt file which is currently in
omap-tutoria/clientSimulator/scripts directory.

They should be next to this file or in the dedicated platform
directory once the project will be mature.

##Test Directory
A test directory should contains a conf.json file which contains path
to all files needed by the PFW Criteria Tests project to realize Audio
related tests such as:

- The audio criterion file path
- The desired script file
- The desired audio gatherer file
- The test vectors' directory
- The log file
- The desired prefix command (eval for host, adb shell for target)
- The test-platform and remote-process executable name and host
- The html coverage file
- The directory where the coverage generation tool is
- The Pfw domain configuration file (to get from board)

I truly advise to keep those files in the same directory as they could be
platform related. Nevertheless, you can create a common test-scripts
directory for platform independent tests behaviour such as call tests
scripts. To do that, you just have to edit audio-test-script.json file
to point the correct script file.

##Scenario
A scenario file contains all states you want the system pass through.
For example :

```{.json}
    [
        {"setCriterion":{
                            "RoutageState":"Flow"
                        }
        },
        {"setCriterion":{
                            "RoutageState":"Path"
                        }
        },
        {"setCriterion":{
                            "Mode":"Normal",
                            "SelectedOutputDevices":"Earpiece",
                            "OpenedPlaybackRoutes":"Media DeepMedia HwCodec0IA",
                            "RoutageState":"Configure"
                        }
        },
        {"script":"play"},
        {"setCriterion":{
                            "RoutageState":"Path Configure"
                        }
        },
        {"setCriterion":{
                            "RoutageState":"Flow Path Configure"
                        }
        }
    ]
```

This json file describe the five steps to put the system in playback state.

The *setCriterion* type allows user to offer a dictionary describing changing
criterions. Other criterions keep there old values.

The other type, *script* allows users to launch a script when he wants.

You can also define your own types based on the system ones, defined ones.
You have to edit the *ActionGathererFile* specified in the *conf.json* file
to do that.
This file has this pattern :

```{.json}
    {
        "mute":
            {"setCriterion":
                {"RoutageState":"Flow"}
            },
        "disable":
            {"setCriterion":
                {"RoutageState":"Path"}
            },
        "configure":
            {"setCriterion":
                {"RoutageState":"Configure"}
            },
        "enable":
            {"setCriterion":
                {"RoutageState":"Path Configure"}
            },
        "unmute":
            {"setCriterion":
                {"RoutageState":"Flow Path Configure"}
            }
    }
```

Here we define five new types based on *setCriterion*. When writing a scenario,
we can now use those types as basis and add some criterions to set in the same
time.

Here is an example of the obtained format :

```{.json}
    [
        {"mute":{}},
        {"disable":{}},
        {"configure":
            {"Mode":"Normal",
             "SelectedOutputDevices":"Earpiece",
             "OpenedPlaybackRoutes":"Media DeepMedia HwCodec0IA"
            }
        },
        {"script":"play"},
        {"enable":{}},
        {"unmute":{}}
    ]
```

During the configure step, the Mode, SelectedOutputDevices and the OpenedPlaybackRoutes
criterions are setted, but also the RoutageState one as defined in the *ActionGathererFile*.

##Scripts
Scripts are simple SHELL or something else which can be added to project by
simply adding them to the *ScriptFile* specified in the *conf.json* file.

This file should be as this :

```{.json}
    {
        "play":["test-scripts/play.sh","asynchronous"],
        "playVoip":["test-scripts/playVoip.sh","asynchronous"],
        "playTiny":["test-scripts/playTiny.sh","asynchronous"],
        "capture":["test-scripts/capture.sh","asynchronous"],
        "captureTiny":["test-scripts/captureTiny.sh","asynchronous"],
        "loopback":["test-scripts/loopback.sh","asynchronous"],
        "call":["test-scripts/call.sh","synchronous"]
    }
```

This dictionary is composed as this :

``` name:["path/to/script","Boolean"] ```

The Boolean is used to decide if we want to wait the end of the script before
continue the execution of the script or not. For example, when running audio
playing command (as alsa_aplay), we don't want the script to wait the end
before to continue. On the contrary, when we make a phone call, we want to be
sure that all commands has been received before we continue.
This Boolean is used as this :

* asynchronous : The script will run concurrently to the pfwCriteriaTest project
* synchronous : The pfwCriteriaTest project will wait the end of the script
before finishing configuration.

