# Grace Development Report

Welcome to the documentation pages of the **Grace**!

* [Installation Guide](#Installation-guide)
   * [Prerequisites](#Prerequisites)
   * [Building](#Building)
   * [Running](#Running)
   * [Optional Resources](#Optional-Resources)

---

## Installation Guide

### Prerequisites
* Install Robot Operative System (ROS) Melodic. We used specifically **ROSberryPi**, a ROS Melodic distro for Raspbian Buster, but any Ubuntu version will do (Ubuntu 18.04.3 LTS is recommended).

* Install Motion, a video streaming software solution essential for the GraceVision feature. You can do this by running the following command:

```
$ sudo apt-get install motion 
```

* Find the Raspberry Pi's IP address. You will need this information in order to remotely control Grace and watch video feedback through the app.

```
$ hostname -I
```

* Once that is done, simply replace the file motion.conf in the /etc/motion/ directory by [this one][motion conf file]. Repeat the same process with the /etc/default/motion file by replacing it by [this one][motion file].

### Building
Copy the files located [here][ros nodes module] into the src folder inside the catkin workspace and compile it.

```
$ cd catkin_workspace
$ catkin make
```

### Running
First, you must have a roscore running in order for ROS nodes to communicate. It is launched using the roscore command. 

```
$ roscore
```

The rosrun process allows you to run Grace's executable in an arbitrary package from anywhere without having to give its full path or cd/roscd there first.

```
$ rosrun grace keyboard_listener
```

### Optional Resources

* It is possible to use this [simulator][simulator] to test the robot's behaviour without an assembled robot.

[comment]: <> ( ------------------------------------------------------- )
[comment]: <> ( ------------------------ LINKS ------------------------ )
[comment]: <> ( ------------------------------------------------------- )

[simulator]: https://github.com/ee09115/conde_simulator "Conde Simulator"
[ros nodes module]: https://github.com/softeng-feup/open-cx/tree/master/open_cx_robot_grace/ros_nodes "ROS Nodes Module"
[motion file]: https://github.com/softeng-feup/open-cx/tree/master/open_cx_robot_grace/motion/motion "Motion File"
[motion conf file]: https://github.com/softeng-feup/open-cx/tree/master/open_cx_robot_grace/motion/motion.conf "Motion Conf File"
