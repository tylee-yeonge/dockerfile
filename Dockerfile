FROM osrf/ros:humble-desktop-full
# FROM ubuntu:jammy-20211122
# WORKDIR /
# COPY startup.sh .
# ENTRYPOINT ["sh", "/startup.sh"]

RUN mkdir /map-data
WORKDIR /map-data
COPY map.yaml .
COPY map.pgm .

RUN mkdir -p /humble-ws/src
WORKDIR /humble-ws
COPY build.sh .

WORKDIR /installer
COPY install-humble.sh .
COPY install-nav2.sh .
COPY install-gazebo-for-humble.sh .
COPY install-aws-warehouse.sh .
COPY install-turtlebot3.sh .
COPY apply-turtlebot3-in-aws-warehouse.sh .
COPY adjust-detecting-lider-distance.sh .
COPY model.sdf .
COPY no_roof_small_warehouse.world .
COPY turtlebot3_in_aws_warehouse.launch.py .

RUN sh install-humble.sh
RUN sh install-nav2.sh
RUN sh install-gazebo-for-humble.sh
RUN sh install-aws-warehouse.sh
RUN sh install-turtlebot3.sh
RUN sh apply-turtlebot3-in-aws-warehouse.sh
RUN sh adjust-detecting-lider-distance.sh
RUN cp turtlebot3_in_aws_warehouse.launch.py /humble-ws/src/aws-robomaker-small-warehouse-world/launch

COPY set-vi.sh .
RUN apt install vim -y
RUN sh set-vi.sh

RUN rm -rf /installer

WORKDIR /humble-ws
COPY build.sh .
# RUN sh build.sh
COPY start-gazebo.bash .
COPY start-nav2.bash .
COPY start-rviz.bash .