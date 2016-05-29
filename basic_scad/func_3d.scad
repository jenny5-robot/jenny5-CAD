// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function heat_sink_height(number_of_wings) = 2 * number_of_wings - 1;

function f_latime_linear_bearing_housing(bearing_height) = bearing_height + 2 * wall_thick_3;
function f_latime_linear_bearing_housing_small(bearing_height) = bearing_height + 2 * wall_thick_2;
function f_lungime_linear_bearing_housing(bearing_radius) = 2 * (bearing_radius + wall_thick_2 + m4_screw_radius + 6);



function f_inaltime_linear_bearing_housing(bearing_radius) = 2 * bearing_radius + wall_thick_3;
//function f_inaltime_linear_bearing_housing_extra(bearing_radius, extra_height, ) = bearing_radius + wall_thick_3 + extra_height;

function f_lungime_support_ghidaj_reglabil(ghidaj_radius, perete_ghidaj_reglabil) = 4 * washer_4_12_radius + 2 * perete_ghidaj_reglabil + 2 * ghidaj_radius;

function f_lungime_support_ghidaj_fix_rotund(ghidaj_radius, perete_ghidaj_reglabil) = 4 * washer_4_12_radius + 2 * perete_ghidaj_reglabil + 2 * ghidaj_radius;

function f_lungime_support_ghidaj_fix_rotund_lung(ghidaj_radius, perete_ghidaj_reglabil) = 4 * washer_4_12_radius + 2 * perete_ghidaj_reglabil + 2 * ghidaj_radius + 5.4;

function f_latime_support_ghidaj_reglabil_slim(ghidaj_radius, toleranta_ghidaj, perete_sustinere_m3_support_ghidaj_reglabil) = 2 * ghidaj_radius + 2 * wall_thick_4;//4 * perete_sustinere_m3_support_ghidaj_reglabil + 2 * (m3_nut_height + m3_tolerance);

function f_latime_support_ghidaj_fix(ghidaj_radius, toleranta_ghidaj, perete_sustinere_m3_support_ghidaj_reglabil) = 2 * ghidaj_radius + 2 * wall_thick_4;
//4 * perete_sustinere_m3_support_ghidaj_reglabil + 2 * (m3_nut_height + m3_tolerance);


function f_inaltime_baza_up_screw_support(bearing_height) =  bearing_height + wall_thick_2;

function f_dist_to_screw_linear_bearing_housing(bearing_external_radius) = bearing_external_radius + wall_thick_2 + m4_screw_radius;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////// ------- tests -------- ///////////////////

//heat_sink(10, 3, 2);

//my_cube_sferic(10, 20, 3);

//colt_sferic(4);

//my_cube_rounded(10,20,2);