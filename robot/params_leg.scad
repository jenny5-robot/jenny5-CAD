// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

latura_U_mare = latura_U_40x40;
latura_U_mic = latura_U_40x40;

lungime_teava = 30;
latime_teava = 30;
grosime_perete_teava = 3;

lungime_talpa = 120;
latime_talpa = 58;
inaltime_os_picior = 450;
dist_to_incheietura = rb_608_external_radius + 3;
dist_to_incheietura_talpa = 32;
dist_to_incheietura_talpa_motor = dist_to_incheietura_talpa;
dist_to_incheietura_talpa_os = 32;//80;

dist_to_motor = 15;

raza_ax = 4;

grosime_placa_alu = 10;

max_torque_leg_angle = 60;

dist_to_surub = (lungime_talpa - 30) * sin (max_torque_leg_angle);//100;