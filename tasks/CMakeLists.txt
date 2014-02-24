# Generated from orogen/lib/orogen/templates/tasks/CMakeLists.txt

include(rock_gmappingTaskLib)


add_definitions(-DBASE_LOG_NAMESPACE=${PROJECT_NAME})

include(FindPkgConfig)

pkg_check_modules(BASE REQUIRED "base-lib")
include_directories(${BASE_INCLUDE_DIRS})
link_directories(${BASE_LIBRARY_DIRS})



find_package(Boost REQUIRED COMPONENTS thread)
find_package(gmapping REQUIRED)


include_directories(${gmapping_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

ADD_LIBRARY(${ROCK_GMAPPING_TASKLIB_NAME} SHARED 
    ${ROCK_GMAPPING_TASKLIB_SOURCES})
add_dependencies(${ROCK_GMAPPING_TASKLIB_NAME}
    regen-typekit)

TARGET_LINK_LIBRARIES(${ROCK_GMAPPING_TASKLIB_NAME}
    ${OrocosRTT_LIBRARIES}
    ${gmapping_LIBRARIES} 
    ${Boost_LIBRARIES} 
    ${ROCK_GMAPPING_TASKLIB_DEPENDENT_LIBRARIES}
    ${BASE_LIBRARIES})
SET_TARGET_PROPERTIES(${ROCK_GMAPPING_TASKLIB_NAME}
    PROPERTIES LINK_INTERFACE_LIBRARIES "${ROCK_GMAPPING_TASKLIB_INTERFACE_LIBRARIES}")

INSTALL(TARGETS ${ROCK_GMAPPING_TASKLIB_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib/orocos)

INSTALL(FILES ${ROCK_GMAPPING_TASKLIB_HEADERS}
    DESTINATION include/orocos/rock_gmapping)

