# Jenny5 robot - CAD files

A human size, multi purpose, almost humanoid, robot.

## Software needed

OpenSCAD from http://www.openscad.org/. Make sure that you have the latest development snapshot which can be downloaded from menu _Downloads_ of the webpage.

## How to compile

Go to [robot](robot) folder, open _jenny5.scad_ file with OpenSCAD and press *Preview* button (or *F5*) ... and wait for several seconds (or minutes if you have a slow computer).

The press *View all* button (or *Ctrl+Shift+V*) to view the entire robot and use the mouse to navigate.
 
 Note that left button drag means rotate, right button drag means move and the wheel means zoom.
 
## Project structure ##

The project is divided into several folders:

- [robot](robot) folder, which contains parts specific to Jenny 5 robot.
- [basic_scad](basic_scad) folder, which contains general parts (like motors, bearings, screws, nuts, housings, etc) which are required to build the robot or something else.


The [robot](robot) folder contains 5 subfolders:

- [arm](robot/arm). The main file is _arm.scad_.
- [base_platform](robot/base_platform). The main file is _base_platform.scad_
- [body](robot/body). The main file is _body.scad_. Please note that arms are connected to body only in the main file of the project ( _jenny5.scad_ ).
- [head](robot/head). The main file is _head.scad_.
- [leg](robot/leg). The main file is _leg.scad_.


## Warning

This is work in progress.

## Contact author

**Mihai Oltean**

https://www.jenny5.org

https://github.com/jenny5-robot

https://groups.google.com/forum/#!forum/jenny5

email: mihai.oltean@gmail.com


## License

MIT License