# components.cmake

# component ARM::CMSIS:CORE@6.1.1
add_library(ARM_CMSIS_CORE_6_1_1 INTERFACE)
target_include_directories(ARM_CMSIS_CORE_6_1_1 INTERFACE
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
  "${CMSIS_PACK_ROOT}/ARM/CMSIS/6.2.0/CMSIS/Core/Include"
)
target_compile_definitions(ARM_CMSIS_CORE_6_1_1 INTERFACE
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
target_link_libraries(ARM_CMSIS_CORE_6_1_1 INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)

# component Keil::Device:Startup@1.0.1
add_library(Keil_Device_Startup_1_0_1 OBJECT
  "${SOLUTION_ROOT}/Project0/RTE/Device/TM4C123GH6PM/startup_TM4C123.s"
  "${SOLUTION_ROOT}/Project0/RTE/Device/TM4C123GH6PM/system_TM4C123.c"
)
target_include_directories(Keil_Device_Startup_1_0_1 PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
  "${CMSIS_PACK_ROOT}/Keil/TM4C_DFP/1.1.0/Device/Include/TM4C123"
)
target_compile_definitions(Keil_Device_Startup_1_0_1 PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
target_compile_options(Keil_Device_Startup_1_0_1 PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Keil_Device_Startup_1_0_1 PUBLIC
  ${CONTEXT}_ABSTRACTIONS
)
set(COMPILE_DEFINITIONS
  TM4C123GH6PM
  _RTE_
)
cbuild_set_defines(AS_ARM COMPILE_DEFINITIONS)
set_source_files_properties("${SOLUTION_ROOT}/Project0/RTE/Device/TM4C123GH6PM/startup_TM4C123.s" PROPERTIES
  COMPILE_FLAGS "${COMPILE_DEFINITIONS}"
)
