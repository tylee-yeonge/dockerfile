#!/bin/bash

apt update -y

# Gazebo 설치
apt install -y ros-humble-gazebo-ros-pkgs

apt-get install pyqt5-dev-tools -y
python3 -m pip install --upgrade pip
python3 -m pip install -U catkin_pkg cryptography empy ifcfg lark-parser lxml netifaces numpy opencv-python pyparsing pyyaml setuptools rosdistro
python3 -m pip install -U pydot PyQt5

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "export TURTLEBOT3_MODEL=waffle" >> ~/.bashrc
echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc

