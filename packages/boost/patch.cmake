# Patch boost
include("${EP_SCRIPT_CONFIG}")
include("${GENERIC_CMAKE_ENVIRONMENT}")

# On Windows, it is assumed that bin64 and lib64 are always used for
# the installed ICU libraries.  This isn't correct.

foreach(file "${SOURCE_DIR}/libs/locale/build/Jamfile.v2"
        "${SOURCE_DIR}/libs/regex/build/Jamfile.v2")
  file(READ "${file}" DATA)
  string(REPLACE /bin64 /bin DATA "${DATA}")
  string(REPLACE /lib64 /lib DATA "${DATA}")
  file(WRITE "${file}" "${DATA}")
endforeach()

# Apply patches from the patches dir
execute_process(COMMAND ${CMAKE_COMMAND}
                        "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
                        "-DPATCH_DIR:PATH=${PATCH_DIR}"
                        "-DCONFIG:INTERNAL=${CONFIG}"
                        "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
                        -P "${GENERIC_PATCH}"
                WORKING_DIRECTORY "${SOURCE_DIR}"
                RESULT_VARIABLE patch_result)

if (patch_result)
  message(FATAL_ERROR "boost: Patch failed")
endif()
