use <../basic_scad/basic_components.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

use <../basic_scad/pulleys.scad>
use <../basic_scad/screws_nuts_washers.scad>

include <../basic_scad/config.scad>

//---------------------------------------------------------------------------
module gradient_support()
{  
    difference(){
        color(plastic_color)
        union(){
         my_pulley(60, 33, 0, 18, 8, 8, 20, 1, 1);// motor head
          translate ([0, 0, 11]) cylinder (h = 9, r = 27.3, $fn = 100);
        }
        translate ([0, 0, 11]) cylinder (h = 15, r = 26, $fn = 100);
        // screw hole
        translate (-display_tolerance_z) cylinder (h = 13, r = 4, $fn = 20);
        // nut hole
        translate (-display_tolerance_z) cylinder (h = m8_nut_thick, r = m8_nut_radius, $fn = 6);

    }
}
//---------------------------------------------------------------------------
module gradient_support_with_screw(screw_length)
{
    gradient_support();
    M8_hexa(100);
}
//---------------------------------------------------------------------------

gradient_support();

//gradient_support_with_screw(100);