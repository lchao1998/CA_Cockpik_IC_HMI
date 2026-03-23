cmake_minimum_required(VERSION 3.18)

project(CA_Cockpik_IC_HMI LANGUAGES CXX)

option(SIMULATION "simulate display data" OFF)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Gui Qml Quick)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

if (WIN32)
    add_definitions(-DWINDOWS)
    #add_definitions(-DSpecialEffects_Switch)
    add_executable(CA_Cockpik_IC_HMIApp
        src/main.cpp
        src/datamodel.h
        src/fpslabel.cpp
        src/fpslabel.h
        src/win/gaugedatamodel.h
        src/win/gaugedatamodel.cpp
        src/win/telltaledatamodel.h
        src/win/telltaledatamodel.cpp
        src/win/warningdatamodel.h
        src/win/warningdatamodel.cpp
        src/win/tripcomputerdatamodel.h
        src/win/tripcomputerdatamodel.cpp
        src/win/statusdatamodel.h
        src/win/statusdatamodel.cpp
        src/win/adasdatamodel.h
        src/win/adasdatamodel.cpp
        CA_Cockpik_IC_HMI.qrc)
elseif(SIMULATION)
    aux_source_directory(../CA_Cockpik_IC_HMIControllers/src/sharedmemory DATA_MODEL_SOURCE)
    include_directories(../CA_Cockpik_IC_HMIControllers/inc)
    include_directories(../CA_Cockpik_IC_HMIControllers/src/sharedmemory)
    set(LINUX_LIB rt)

    add_definitions(-DSIMULATION)
    add_executable(CA_Cockpik_IC_HMIApp
        src/main.cpp
        src/datamodel.h
        src/fpslabel.cpp
        src/fpslabel.h
        src/win/gaugedatamodel.h
        src/win/gaugedatamodel.cpp
        src/win/telltaledatamodel.h
        src/win/telltaledatamodel.cpp
        src/win/warningdatamodel.h
        src/win/warningdatamodel.cpp
        src/win/tripcomputerdatamodel.h
        src/win/tripcomputerdatamodel.cpp
        src/win/statusdatamodel.h
        src/win/statusdatamodel.cpp
        src/win/adasdatamodel.h
        src/win/adasdatamodel.cpp
        ${DATA_MODEL_SOURCE}
        CA_Cockpik_IC_HMI.qrc)
else ()
    aux_source_directory(../CA_Cockpik_IC_HMIControllers/src/sharedmemory DATA_MODEL_SOURCE)
    include_directories(../CA_Cockpik_IC_HMIControllers/inc)
    include_directories(../CA_Cockpik_IC_HMIControllers/src/sharedmemory)
    set(LINUX_LIB rt)

    add_executable(CA_Cockpik_IC_HMIApp
        src/main.cpp
        src/datamodel.h
        src/fpslabel.cpp
        src/fpslabel.h
        src/gaugedatamodel.h
        src/gaugedatamodel.cpp
        src/telltaledatamodel.h
        src/telltaledatamodel.cpp
        src/warningdatamodel.h
        src/warningdatamodel.cpp
        src/tripcomputerdatamodel.h
        src/tripcomputerdatamodel.cpp
        src/statusdatamodel.h
        src/statusdatamodel.cpp
        src/adasdatamodel.h
        src/adasdatamodel.cpp
        ${DATA_MODEL_SOURCE}
        CA_Cockpik_IC_HMI.qrc)
endif()

target_link_libraries(CA_Cockpik_IC_HMIApp PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
    ${LINUX_LIB}
)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)
install(TARGETS CA_Cockpik_IC_HMIApp RUNTIME DESTINATION bin/hmi)
install(FILES content/fonts/SourceHanSansCN-Normal.otf DESTINATION share/fonts/otf)
