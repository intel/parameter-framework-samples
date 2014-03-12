#! /bin/bash

# replace the path in the xml file to our local path
# since it depends on where the user cloned the example
replacePaths()
{
    CURRENTDIR=$( pwd )
    PLUGINDIR=$1
    echo $PLUGINDIR
    tmpFile=$( mktemp )
    # plugin directory
    sed s@'Folder=.*"'@Folder=\"${PLUGINDIR}\"@ ParameterFrameworkConfiguration.xml > $tmpFile
    cat $tmpFile > ParameterFrameworkConfiguration.xml

    # music root directory
    cd Structure/FS
    sed s@'Directory:/.*"'@Directory:${CURRENTDIR}\"@ my_music.xml > $tmpFile
    cat $tmpFile > my_music.xml
}

if [ $# -ne 1 ]
then
    echo "Usage: $0 pfw_install_dir" >&2
    exit 1
fi

PWFINSTALLDIR=$1

replacePaths "$PWFINSTALLDIR/lib"
echo "Example installed"
