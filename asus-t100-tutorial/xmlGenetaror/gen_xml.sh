#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib
domainGenerator.py --validate --toplevel-config ../AudioParameterFramework.xml --criteria ../AudioCriteria.txt --initial-settings AudioConfigurableDomainsRealtek564x-Tuning.xml --add-domains SstDefaultGains.xml SstMediaLoop1Fir.xml SstMediaLoop1Iir.xml SstMediaLoop1Mdrc.xml SstMediaLoop2Fir.xml SstMediaLoop2Iir.xml SstMediaLoop2Mdrc.xml --add-edds bytcr-rt5640-default.pfw routing_sst.pfw --schemas-dir ../../../parameter-framework/schemas/ > ../Settings/Audio/AudioConfigurableDomains.xml

