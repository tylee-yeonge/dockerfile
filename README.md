# ROS2 Gazebo ARM64 Docker Environment

ARM64 아키텍처에서 ROS2 Humble과 Gazebo를 이용한 TurtleBot 시뮬레이션 환경을 제공하는 Docker 프로젝트입니다.

## 1. 시스템 요구사항

- **아키텍처**: ARM64 (Apple Silicon Mac, ARM64 Linux)
- **Docker**: Docker Engine 및 Docker Compose 지원
- **GUI 지원**: X11 포워딩을 통한 Gazebo GUI 실행

## 2. 프로젝트 구성

```
dockerfile-gazebo-arm64/
├── Dockerfile              # ROS2 + Gazebo + TurtleBot 환경 구성
├── docker-compose.sh       # Docker Compose 설정 파일
├── entrypoint.sh          # 컨테이너 진입점 스크립트
├── scripts/
│   └── run_turtlebot_house.sh  # TurtleBot 하우스 시뮬레이션 실행
└── README.md
```

## 3. 설치된 컴포넌트

- **ROS2 Humble Hawksbill** (Desktop 버전)
- **Gazebo Classic** (소스 컴파일 버전)
- **TurtleBot3/4 시뮬레이션 패키지**
- **Gazebo ROS 패키지**

## 4. 사용 방법

### 4.1 Docker 이미지 빌드 및 실행

```bash
# 저장소 클론
git clone <repository-url>
cd dockerfile-gazebo-arm64

# Docker Compose를 통한 빌드 및 실행
docker-compose -f docker-compose.sh up -d --build

# 컨테이너 접속
docker exec -it ros2_gazebo_container bash
```

### 4.2 GUI 애플리케이션 실행을 위한 설정

**macOS (XQuartz 사용):**
```bash
# XQuartz 설치 (필요시)
brew install --cask xquartz

# XQuartz 실행 후 X11 포워딩 허용
xhost +localhost
```

**Linux:**
```bash
# X11 포워딩 허용
xhost +local:
```

### 4.3 TurtleBot 시뮬레이션 실행

컨테이너 내부에서:

```bash
# 직접 실행
source /root/turtlebot_gazebo_ws/install/setup.bash
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py

# 또는 제공된 스크립트 사용
./scripts/run_turtlebot_house.sh
```

### 4.4 컨테이너 종료

```bash
# 컨테이너 중지
docker-compose -f docker-compose.sh down
```

## 5. 개발 및 커스터마이징

### 5.1 추가 ROS2 패키지 설치

컨테이너 내부에서:
```bash
# 패키지 설치 예시
apt update && apt install -y ros-humble-<package-name>

# 작업공간 재빌드
cd /root/turtlebot_gazebo_ws
colcon build --symlink-install
```

### 5.2 새로운 시뮬레이션 스크립트 추가

`scripts/` 폴더에 새로운 스크립트를 추가하여 다양한 시뮬레이션 환경을 실행할 수 있습니다.

## 6. 트러블슈팅

### GUI가 표시되지 않는 경우
- X11 포워딩 설정 확인
- `xhost` 명령어로 접근 권한 부여 확인
- `DISPLAY` 환경 변수 설정 확인

### 빌드 시간이 오래 걸리는 경우
- Gazebo를 소스에서 컴파일하므로 ARM64에서는 빌드 시간이 상당히 소요됩니다
- 빌드된 이미지를 재사용하면 이후 실행은 빠릅니다

## 7. 지원되는 시뮬레이션

- **TurtleBot3 House**: 기본 제공되는 하우스 환경 시뮬레이션
- **TurtleBot3/4**: 다양한 TurtleBot 모델 지원

## 8. 참고사항

- 이 프로젝트는 ARM64 아키텍처에 최적화되어 있습니다
- Apple Silicon Mac에서 테스트되었습니다
- 컨테이너는 privileged 모드로 실행되어 GUI 지원을 제공합니다
