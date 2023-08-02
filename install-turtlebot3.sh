#!/bin/bash

WORKSPACE_PATH="/humble-ws"
ROS2_DISTRO="humble"

apt install ros-humble-turtlebot3 -y

cd $WORKSPACE_PATH/src
git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
# cd $WORKSPACE_PATH
# rosdep install --from-paths src --ignore-src -r -y
# colcon build --symlink-install
