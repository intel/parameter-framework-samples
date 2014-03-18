set(PLUGIN_LOCATION_FOLDER "${CMAKE_PREFIX_PATH}/lib")
set(INSTALL_LOCATION_FOLDER ${CMAKE_INSTALL_PREFIX})

message("plugin location = ${PLUGIN_LOCATION_FOLDER}")
message("install location = ${INSTALL_LOCATION_FOLDER}")

configure_file(ParameterFrameworkConfiguration.xml ${CMAKE_INSTALL_PREFIX}/example-music/ParameterFrameworkConfiguration.xml)
configure_file(Structure/MusicLibrary/my_music.xml ${CMAKE_INSTALL_PREFIX}/example-music/Structure/MusicLibrary/my_music.xml)

install(FILES
    Schemas/ComponentLibrary.xsd
    Schemas/ComponentTypeSet.xsd
    Schemas/ConfigurableDomains.xsd
    Schemas/FileIncluder.xsd
    Schemas/ParameterFrameworkConfiguration.xsd
    Schemas/ParameterSettings.xsd
    Schemas/Parameter.xsd
    Schemas/Subsystem.xsd
    Schemas/SystemClass.xsd
    DESTINATION example-music/Schemas)

install(FILES
    Settings/MusicLibrary/Genres.xml
    DESTINATION example-music/Settings/MusicLibrary)

install(FILES
    Structure/MusicLibrary/MusicLibraries.xml
    DESTINATION example-music/Structure/MusicLibrary)

install(FILES
    libraries/myMusic/beethoven
    libraries/myMusic/blackSabbath
    libraries/myMusic/explosionInTheSky
    libraries/myMusic/ironMaiden
    DESTINATION libraries)
