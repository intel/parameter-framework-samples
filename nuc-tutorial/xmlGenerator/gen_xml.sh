#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib
domainGenerator.py --validate   --toplevel-config ../AudioParameterFramework.xml   --criteria ../AudioCriteria.txt   --initial-settings AudioConfigurableDomains-Tuning.xml --add-edds routing_alc283.pfw routing_hdmi.pfw --schemas-dir ../../../parameter-framework/schemas/ >   ../Settings/Audio/AudioConfigurableDomains.xml

