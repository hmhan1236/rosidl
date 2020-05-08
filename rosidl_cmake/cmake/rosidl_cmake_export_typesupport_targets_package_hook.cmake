# Copyright 2020 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# generate and register extra file for typesupport targets
set(_generated_extra_file
  "${CMAKE_CURRENT_BINARY_DIR}/rosidl_cmake/rosidl_cmake_export_typesupport_targets-extras.cmake")
configure_file(
  "${rosidl_cmake_DIR}/rosidl_cmake_export_typesupport_targets-extras.cmake.in"
  "${_generated_extra_file}"
  @ONLY
)
list(APPEND ${PROJECT_NAME}_CONFIG_EXTRAS "${_generated_extra_file}")

# install export files for targets
if(NOT _ROSIDL_CMAKE_EXPORT_TYPESUPPORT_TARGETS STREQUAL "")
  foreach(_tuple ${_ROSIDL_CMAKE_EXPORT_TYPESUPPORT_TARGETS})
    string(REPLACE ":" ";" _tuple "${_tuple}")
    list(GET _tuple 1 _target)
    list(GET _tuple 2 _single_typesupport)
    # For single typesupport builds, the target is already exported with
    # ament_export_targets
    message(WARNING "$single typesupport: ${_single_typesupport}")
    if(NOT "${_single_typesupport}" STREQUAL "TRUE")
      install(
        EXPORT "${_target}"
        DESTINATION share/${PROJECT_NAME}/cmake
        NAMESPACE "${PROJECT_NAME}::"
        FILE "${_target}Export.cmake"
      )
    endif()
  endforeach()
endif()
