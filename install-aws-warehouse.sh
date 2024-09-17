#!/bin/bash

WORKSPACE_PATH="/humble-ws"
ROS2_DISTRO="humble"

cd $WORKSPACE_PATH/src

source /opt/ros/humble/setup.bash 
git clone -b ros2 https://github.com/aws-robotics/aws-robomaker-small-warehouse-world.git
# cd $WORKSPACE_PATH
# rosdep install --from-paths src --ignore-src -r -y
# colcon build --symlink-install
