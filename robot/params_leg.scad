// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings_housing.scad>


angle_knee = 50;


latura_U_mare = latura_U_40x40;
latura_U_mic = latura_U_40x40;

lungime_teava = 30;
latime_teava = 30;
grosime_perete_teava = 3;

lungime_talpa = 260;

inaltime_os_picior = 400;
dist_to_incheietura = rb_608_external_radius + 3;
dist_to_incheietura_talpa = 32;
dist_to_incheietura_talpa_motor = dist_to_incheietura_talpa;
dist_to_incheietura_talpa_os = 32;//80;

dist_to_motor = 15;

raza_ax = 4;

grosime_placa_alu = 10;

max_torque_leg_angle = 60;

distance_to_push_nut = 200; //(lungime_talpa - 30) * sin (max_torque_leg_angle);//100;

crotch_width = 46 + 2 * latime_teava + 2 * 5 + 2 * rb_608_thick;


dist_to_first_spacer = 70;
dist_to_second_spacer = 165;

dist_to_first_bone = 22;
dist_to_second_bone = 110;
dist_to_push_motor_hole = 250;

dist_to_oscior = dist_to_incheietura + 60;

grosime_L_mic = 3;

piesa_impingere_sizes = [30, 30, 24];
lateral_talpa_motor_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa_motor + 10];
//lateral_talpa_os_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa_os + 10];
lateral_talpa_simple_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa + 10];

knee_side_simple_sizes = [dist_to_second_bone + dist_to_first_bone, grosime_placa_alu, 60];

lateral_talpa_sizes = [lungime_talpa, grosime_placa_alu, 40];

foot_spacer_holes = 
[[dist_to_first_spacer, -50, 0],
[dist_to_first_spacer, 50, 0],
[dist_to_second_spacer, -50, 0],
[dist_to_second_spacer, 50, 0]
];
