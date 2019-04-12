// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

nema_17_gearbox_sheet_size = [42, 42, 5];

nema_17_gearbox_alu_sheet_size = [40, 42, 3];

nema_11_gearbox_sheet_size = [40, 40, 5];

dist_to_screw_hole_position = 5;

nema17_gearbox_tensioner_sheet_screw_hole_position = [
[0, 0, 0],
[nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position, nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position, 0],
[nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position, -(nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), 0],
[-(nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position, 0],
[-(nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), -(nema_17_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), 0]

];

nema11_gearbox_tensioner_sheet_screw_hole_position = [
[0, 0, 0],
[nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position,   nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position,    0],
[nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position,   -(nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), 0],
[-(nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position,   0],
[-(nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), -(nema_11_gearbox_sheet_size[0] / 2 - dist_to_screw_hole_position), 0]

];

nema_17_gearbox_sheet_base_wall_thick = 2;
nema_11_gearbox_sheet_base_wall_thick = 2;