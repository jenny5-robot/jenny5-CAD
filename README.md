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

## More details

https://www.jenny5.org

https://github.com/jenny5-robot

https://groups.google.com/forum/#!forum/jenny5

## Contact author

**Mihai Oltean**

email: mihai.oltean@gmail.com


## License

Copyright 2015-2019 [Mihai Oltean](https://mihaioltean.github.io)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.