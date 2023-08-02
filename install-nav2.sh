#!/bin/bash

WORKSPACE_PATH="/humble-ws"
ROS2_DISTRO="humble"

mkdir -p $WORKSPACE_PATH/src
cd $WORKSPACE_PATH/src
git clone https://github.com/ros-planning/navigation2.git --branch $ROS2_DISTRO
# cd $WORKSPACE_PATH
# rosdep install -y -r -q --from-paths src --ignore-src --rosdistro $ROS2_DISTRO
# colcon build --symlink-install
