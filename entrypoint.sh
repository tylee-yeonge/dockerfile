#!/bin/bash
# 이 스크립트는 컨테이너가 시작될 때 실행됩니다.

# Bash 설정 파일을 엄격한 모드로 설정합니다.
set -e

# ROS2 Humble 환경 설정을 로드합니다.
source "/opt/ros/humble/setup.bash"

# TurtleBot 작업 공간의 환경 설정을 로드합니다.
# 파일이 존재할 경우에만 소싱합니다.
if [ -f "/root/turtlebot_gazebo_ws/install/setup.bash" ]; then
  source "/root/turtlebot_gazebo_ws/install/setup.bash"
fi

# 이 스크립트에 전달된 모든 인자(명령)를 실행합니다.
# 예: docker run -it <image> ros2 launch ...
# exec "$@"