version: '3.8'
# Docker Compose 파일을 사용하여 ROS2 및 Gazebo 환경을 관리합니다.
services:
  ros2_gazebo:
    # 현재 디렉터리의 Dockerfile을 사용하여 이미지를 빌드합니다.
    build:
      context: .
      dockerfile: Dockerfile
    # 빌드된 이미지의 이름을 지정합니다.
    image: ros2-gazebo-arm64
    # 컨테이너의 이름을 지정합니다.
    container_name: ros2_gazebo_container
    # 컨테이너가 상호작용 가능한 터미널(tty)을 유지하도록 합니다.
    tty: true
    # 표준 입력을 열어 둡니다.
    stdin_open: true
    # Gazebo와 같은 GUI 애플리케이션을 호스트 머신에 표시하기 위한 설정입니다.
    # 이 설정을 사용하려면 호스트 머신에서 'xhost +' 명령을 먼저 실행해야 할 수 있습니다.
    environment:
      - DISPLAY
      - QT_X11_NO_MITSHM=1
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw
    # --privileged 옵션은 일부 시스템에서 그래픽 장치 접근에 필요할 수 있습니다.
    privileged: true
