// Author: Mihai Oltean, 
// https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//-------------------------------------------------------------- 

include <params_radial_bearings.scad>

wing_thick = 6;
pusher_length = 20;
    
belt_tensioner_external_dist_between_holes = 14;
belt_tensioner_external_size = [belt_tensioner_external_dist_between_holes, 10, 2 * wing_thick + 2 * rb_624_thick + 2];
//echo(belt_tensioner_external_size=belt_tensioner_external_size);