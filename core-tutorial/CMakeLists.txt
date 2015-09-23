configure_file(Structure/MyMusic.xml.in ${CMAKE_CURRENT_BINARY_DIR}/Structure/MyMusic.xml @ONLY)

install(FILES
    ParameterFrameworkConfiguration.xml
    DESTINATION .)

install(FILES
    Settings/Genres.xml
    DESTINATION Settings)

install(FILES
    Structure/MusicLibraries.xml
    ${CMAKE_CURRENT_BINARY_DIR}/Structure/MyMusic.xml
    DESTINATION Structure)

install(FILES
    libraries/myMusic/beethoven
    libraries/myMusic/blackSabbath
    libraries/myMusic/explosionInTheSky
    libraries/myMusic/ironMaiden
    DESTINATION libraries)
