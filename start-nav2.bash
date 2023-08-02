#!/bin/bash
cd ~/Documents/simulation_ws
source install/setup.bash
ros2 launch nav2_bringup bringup_launch.py use_sim_time:=True autostart:=False map:=$HOME/map.yaml
