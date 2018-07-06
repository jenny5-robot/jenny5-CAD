// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

as5147_board_size = [28, 22, 2];

as5147_space_between_holes_length = 11;
as5147_space_between_holes_width = 18;
as5147_distance_hole_from_margin = 2;

as5147_holes_position = [
[as5147_distance_hole_from_margin, as5147_distance_hole_from_margin, 0],
[as5147_distance_hole_from_margin + as5147_space_between_holes_length, as5147_distance_hole_from_margin, 0],
[as5147_distance_hole_from_margin, as5147_distance_hole_from_margin + as5147_space_between_holes_width, 0],
[as5147_distance_hole_from_margin + as5147_space_between_holes_length, as5147_distance_hole_from_margin + as5147_space_between_holes_width, 0],
];

as5147_pin_area_length = 7.5;

as5147_sensor_center = [as5147_distance_hole_from_margin + as5147_space_between_holes_length / 2, as5147_space_between_holes_length + as5147_space_between_holes_width / 2];