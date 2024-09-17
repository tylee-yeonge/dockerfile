#!/bin/bash
source /opt/ros/humble/setup.bash
rosdep install -y -r -q --from-paths src --ignore-src --rosdistro humble
source /humble-ws/install/setup.bash
colcon build --symlink-install