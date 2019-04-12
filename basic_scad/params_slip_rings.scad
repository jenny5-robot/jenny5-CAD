// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

SRC022A_6_stator_length = 19;
SRC022A_6_stator_radius = 11;
SRC022A_6_flange_radius = 22;
SRC022A_6_rotor_radius = 3.9;
SRC022A_6_rotor_length = 9;
SRC022A_6_flange_thickness = 2.4;
SRC022A_6_flange_holes_radius = 2.75;
SRC022A_6_flange_holes_position_radius = 17.5;

SRC022A_6_flange_holes_position = [
[0, 0, 0],
[SRC022A_6_flange_holes_position_radius * sin(30), SRC022A_6_flange_holes_position_radius * cos(30), 0],
[SRC022A_6_flange_holes_position_radius * sin(150), SRC022A_6_flange_holes_position_radius * cos(150), 0],
[SRC022A_6_flange_holes_position_radius * sin(270), SRC022A_6_flange_holes_position_radius * cos(270), 0]
];