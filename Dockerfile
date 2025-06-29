# Step 1: Base Image (Ubuntu 22.04 for ROS2 Humble)
# ARM64 아키텍처를 지원하는 Ubuntu 22.04를 기반 이미지로 사용합니다.
FROM --platform=linux/arm64 ubuntu:22.04

# Step 2: Set Environment Variables
# 패키지 설치 중 발생할 수 있는 대화형 프롬프트를 방지하고, UTF-8 로케일을 설정합니다.
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Step 3: Initial Setup & ROS2 Repository Configuration
# 기본적인 유틸리티를 설치하고, ROS2 저장소를 시스템에 추가합니다.
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    gnupg \
    lsb-release \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Step 4: Install ROS2 Humble
# ROS2 Humble Hawksbill 데스크톱 버전과 개발 도구를 설치합니다.
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*

# Step 5: Install Gazebo Dependencies
# Gazebo를 소스 코드로부터 컴파일하기 위해 필요한 모든 의존성 패키지를 설치합니다.
# PPA 추가와 패키지 설치를 한 번에 실행합니다.
RUN add-apt-repository ppa:dartsim/ppa -y && \
    apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    libdart-dev \
    libdart-utils-dev \
    libdart-external-ikfast-dev \
    libsdformat9-dev \
    libfreeimage-dev \
    libprotoc-dev \
    libprotobuf-dev \
    protobuf-compiler \
    freeglut3-dev \
    libcurl4-openssl-dev \
    libtinyxml-dev \
    libtinyxml2-dev \
    libtar-dev \
    libtbb-dev \
    libogre-1.9-dev \
    libxml2-dev \
    pkg-config \
    qtbase5-dev \
    libqwt-qt5-dev \
    libltdl-dev \
    libgts-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-iostreams-dev \
    libsimbody-dev \
    libignition-common3-dev \
    libignition-fuel-tools4-dev \
    libignition-transport8-dev \
    libignition-math6-dev \
    libignition-msgs5-dev \
    && rm -rf /var/lib/apt/lists/*

# Step 6: Clone, Patch, and Compile Gazebo
# Gazebo 소스 코드를 클론하고, Ubuntu 22.04 환경에 맞게 CMake 파일을 수정한 후, 컴파일 및 설치합니다.
RUN mkdir /gazebo
WORKDIR /gazebo
RUN git clone https://github.com/tylee-yeonge/gazebo-classic.git && \
    mv gazebo-classic gazebo

# Gazebo 컴파일 및 설치 (사용 가능한 모든 CPU 코어를 사용하여 빌드 속도를 높입니다.)
RUN mkdir -p /gazebo/build
WORKDIR /gazebo/build
RUN cmake .. && \
    make -j$(nproc) && \
    make install

# Step 7: Set Gazebo Environment Path
# Gazebo 실행 파일과 라이브러리를 시스템 경로에 추가합니다.
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/bin:$PATH
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
# 시스템 라이브러리 캐시를 업데이트합니다.
RUN ldconfig

# Step 8: Compile TurtleBot3/4 Packages
# TurtleBot 시뮬레이션을 위한 ROS2 패키지를 설치하고 작업 공간을 빌드합니다.
RUN mkdir -p /turtlebot_gazebo_ws/src
WORKDIR /turtlebot_gazebo_ws/src
RUN git clone https://github.com/tylee-yeonge/turtlebot3_simulations -b humble && \
    git clone https://github.com/ros-simulation/gazebo_ros_pkgs -b ros2 && \
    git clone https://github.com/turtlebot/turtlebot4 -b humble

# TurtleBot 패키지 의존성 설치
RUN apt-get update && apt-get install -y \
    ros-humble-camera-info-manager \
    ros-humble-irobot-create-msgs \
    && rm -rf /var/lib/apt/lists/*

# 작업 공간 컴파일
WORKDIR /turtlebot_gazebo_ws
# RUN 명령어 내에서 ROS 환경을 소싱하여 colcon build를 실행합니다.
RUN . /opt/ros/humble/setup.sh && colcon build --symlink-install

# Step 9: Configure Entrypoint
# 컨테이너가 시작될 때마다 ROS 및 TurtleBot 작업 공간의 환경 설정을 자동으로 로드하도록 설정합니다.
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 기본적으로 bash 셸을 실행합니다.
CMD ["bash"]