#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib
domainGenerator.py --validate   --toplevel-config ../AudioParameterFramework.xml   --criteria AudioCriteria.txt   --initial-settings ../Settings/Audio/AudioConfigurableDomains-Tuning.xml   --add-edds bytcr-rt5640-default.pfw routing_sst.pfw   --schemas-dir ../../../parameter-framework/schemas/ >   ../Settings/Audio/AudioConfigurableDomains.xml

