# groups.cmake

# group Source
add_library(Group_Source OBJECT
  "${SOLUTION_ROOT}/main.c"
  "${SOLUTION_ROOT}/bsp.c"
)
target_include_directories(Group_Source PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
  "${SOLUTION_ROOT}/."
)
target_compile_definitions(Group_Source PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Source_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Source_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Source PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Source PUBLIC
  Group_Source_ABSTRACTIONS
)

# group ek-tm4c123gxl
add_library(Group_ek-tm4c123gxl OBJECT
  "${SOLUTION_ROOT}/../ek-tm4c123gxl/arm/startup_TM4C123GH6PM.s"
  "${SOLUTION_ROOT}/../ek-tm4c123gxl/system_TM4C123GH6PM.c"
)
target_include_directories(Group_ek-tm4c123gxl PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
  "${SOLUTION_ROOT}/../ek-tm4c123gxl"
)
target_compile_definitions(Group_ek-tm4c123gxl PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_ek-tm4c123gxl_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_ek-tm4c123gxl_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_ek-tm4c123gxl PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_ek-tm4c123gxl PUBLIC
  Group_ek-tm4c123gxl_ABSTRACTIONS
)
set(COMPILE_DEFINITIONS
  Stack_Size=2048
  Heap_Size=0
  TM4C123GH6PM
)
cbuild_set_defines(AS_ARM COMPILE_DEFINITIONS)
set_source_files_properties("${SOLUTION_ROOT}/../ek-tm4c123gxl/arm/startup_TM4C123GH6PM.s" PROPERTIES
  COMPILE_FLAGS "${COMPILE_DEFINITIONS}"
)

# group CMSIS
add_library(Group_CMSIS INTERFACE)
target_include_directories(Group_CMSIS INTERFACE
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
  "${SOLUTION_ROOT}/../CMSIS/Include"
)
target_compile_definitions(Group_CMSIS INTERFACE
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_CMSIS_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_CMSIS_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
