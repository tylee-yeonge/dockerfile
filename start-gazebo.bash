#!/bin/bash
cd ~/Documents/simulation_ws
source install/setup.bash
export TURTLEBOT3_MODEL=waffle && export WAREHOUSE_MODEL=small_warehouse
ros2 launch aws_robomaker_small_warehouse_world turtlebot3_in_aws_warehouse.launch.py
