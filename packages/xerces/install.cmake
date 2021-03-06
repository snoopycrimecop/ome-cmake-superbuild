# Install xerces
include("${EP_SCRIPT_CONFIG}")
include("${GENERIC_CMAKE_ENVIRONMENT}")
include("${CMAKE_CURRENT_LIST_DIR}/common.cmake")

if(WIN32)

  set(XERCES_BINARY_DIR "${SOURCE_DIR}/Build/${XERCES_PLATFORM_PATH}/${XERCES_SOLUTION}/${XERCES_CONFIG}")

  message(STATUS "Installing xerces (Windows)")

  file(GLOB XERCES_DLLS "${XERCES_BINARY_DIR}/xerces-c*.dll")
  file(GLOB XERCES_ILKS "${XERCES_BINARY_DIR}/xerces-c*.ilk")
  file(GLOB XERCES_EXPS "${XERCES_BINARY_DIR}/xerces-c*.exp")
  file(GLOB XERCES_LIBS "${XERCES_BINARY_DIR}/xerces-c*.lib")
  file(GLOB XERCES_PDBS "${XERCES_BINARY_DIR}/xerces-c*.pdb")
  file(GLOB_RECURSE XERCES_HDRS
       RELATIVE ${SOURCE_DIR}/src/xercesc
       "${SOURCE_DIR}/src/xercesc/*.hpp"
       "${SOURCE_DIR}/src/xercesc/*.c")

  file(INSTALL ${XERCES_DLLS}
       DESTINATION "${OME_EP_BIN_DIR}")
  file(INSTALL ${XERCES_ILKS}
       DESTINATION "${OME_EP_BIN_DIR}")
  file(INSTALL ${XERCES_EXPS}
       DESTINATION "${OME_EP_LIB_DIR}")
  file(INSTALL ${XERCES_LIBS}
       DESTINATION "${OME_EP_LIB_DIR}")
  file(INSTALL ${XERCES_PDBS}
       DESTINATION "${OME_EP_LIB_DIR}")
  foreach(hdr ${XERCES_HDRS})
    get_filename_component(hdir "${hdr}" DIRECTORY)
    file(MAKE_DIRECTORY "${OME_EP_INCLUDE_DIR}/xercesc/${hdir}")
    file(INSTALL "${SOURCE_DIR}/src/xercesc/${hdr}"
         DESTINATION "${OME_EP_INCLUDE_DIR}/xercesc/${hdir}")
  endforeach()

else()

  message(STATUS "Installing xerces (Unix)")

  execute_process(COMMAND ${OME_MAKE_PROGRAM} install
                  WORKING_DIRECTORY ${BUILD_DIR}
                  RESULT_VARIABLE install_result)

  if (install_result)
    message(FATAL_ERROR "xerces: Install failed")
  endif()

endif()


