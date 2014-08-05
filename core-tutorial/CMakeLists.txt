set(PLUGIN_LOCATION_FOLDER "${CMAKE_PREFIX_PATH}/lib")
set(INSTALL_LOCATION_FOLDER ${CMAKE_INSTALL_PREFIX})

message("plugin location = ${PLUGIN_LOCATION_FOLDER}")
message("install location = ${INSTALL_LOCATION_FOLDER}")

configure_file(ParameterFrameworkConfiguration.xml ${CMAKE_INSTALL_PREFIX}/ParameterFrameworkConfiguration.xml)
configure_file(Structure/MyMusic.xml ${CMAKE_INSTALL_PREFIX}/Structure/MyMusic.xml)

install(FILES
    Settings/Genres.xml
    DESTINATION Settings)

install(FILES
    Structure/MusicLibraries.xml
    DESTINATION Structure)

install(FILES
    libraries/myMusic/beethoven
    libraries/myMusic/blackSabbath
    libraries/myMusic/explosionInTheSky
    libraries/myMusic/ironMaiden
    DESTINATION libraries)
