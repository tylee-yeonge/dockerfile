#!/bin/bash

WORKSPACE_PATH="/humble-ws"
ROS2_DISTRO="humble"

cd $WORKSPACE_PATH=src/turtlebot3_simulations/turtlebot3_gazebo/models
cp -r turtlebot3_waffle $WORKSPACE_PATH/src/aws-robomaker-small-warehouse-world/worlds
cp no_roof_small_warehouse.world $WORKSPACE_PATH/src/aws-robomaker-small-warehouse-world/worlds/no_roof_small_warehouse/no_roof_small_warehouse.world
