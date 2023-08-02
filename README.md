# dockerfile - nav2-sim-humble
## 개요
- ROS2 Humble 기반 simulation docker 생성

## 개발 환경
- Ubuntu 22.04 LTS
- ROS2 Humble
- ROS2 Navigation2
- docker
- Turtlebot3

# 사용 방법
1. 설치해당 git repo에서 clone
2. build-docker.bash 편집 및 실행
  - --tag에 원하는 image:tag 형식으로 입력
  - 실행 명령어
    - source build-docker.bash
  - 실행 후 docker에 image 등록됨
3. 등록된 image를 이용하여 container 생성
  - ./create-docker-container.sh {docker-image 이름):{docker-image tag} {생성할 docker container 이름}
  - 예) ./create-docker-container.sh nav2-sim:1.0.0-230801 humble-nav2-sim
4. 등록한 docker container 시작
  - docker start {docker container 이름}
  - 예) docker start humble-nav2-sim
5. x window 사용 설정
  - xhost +local:docker
6. docker container 진입
  - docker exec -it humble-nav2-sim bash
7. 코드 build
  - sh build.sh
8. simulator 실행
  - gazebo 실행
    - source /humble-ws/start-gazebo.bash
  - nav2 실행
    - source /humble-ws/start-nav2.bash
  - rviz 실행
    - source /humble-ws/start-rviz.bash