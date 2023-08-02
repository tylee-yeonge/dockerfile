#!/bin/bash
cd /humble-ws
source /opt/ros/humble/setup.bash && source install/setup.bash
ros2 launch nav2_bringup bringup_launch.py use_sim_time:=True autostart:=False map:=$HOME/map.yaml
