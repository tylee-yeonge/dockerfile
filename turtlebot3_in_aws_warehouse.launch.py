import os

from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import ExecuteProcess, DeclareLaunchArgument
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, PythonExpression
from launch.conditions import IfCondition


TURTLEBOT3_MODEL = os.environ['TURTLEBOT3_MODEL']
WORLD_MODEL = os.environ['WAREHOUSE_MODEL']

def generate_launch_description():
    use_sim_time = LaunchConfiguration('use_sim_time', default='True')

    aws_small_warehouse_dir = os.path.join(get_package_share_directory('aws_robomaker_small_warehouse_world'), 'launch')
    
    if WORLD_MODEL == 'small_warehouse':
        aws_small_warehouse = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([aws_small_warehouse_dir, '/no_roof_small_warehouse.launch.py'])
        )

    elif WORLD_MODEL == 'big_warehouse':
        aws_small_warehouse = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([aws_small_warehouse_dir, '/big_warehouse_launch.py'])
        )


    launch_file_dir = os.path.join(get_package_share_directory('turtlebot3_gazebo'), 'launch')
    robot_state_publisher = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([launch_file_dir, '/robot_state_publisher.launch.py']),
            launch_arguments={'use_sim_time': use_sim_time}.items(),
    )

    ld = LaunchDescription()
    ld.add_action(aws_small_warehouse)
    ld.add_action(robot_state_publisher)

    return ld