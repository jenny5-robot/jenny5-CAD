include <params_ultrasonic.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>



//--------------------------------------------------------------
module hc_sr04()
{
  color("blue") cube([hc_sr04_sizes[0], hc_sr04_sizes[1], 2]);
  color("silver") translate ([hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2, 2]) cylinder_empty (15, hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2 - 1,40);  
    color("silver") translate ([hc_sr04_sizes[0] - hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2, 2]) cylinder_empty (15, hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2 - 1, 40);  
}
//--------------------------------------------------------------

hc_sr04();