use <../basic_scad/basic_components.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>


use <../basic_scad/pulleys.scad>
use <../basic_scad/screws_nuts_washers.scad>

//---------------------------------------------------------------------------
module gradient_pulley()
{
    difference(){
      my_pulley(60, 33, 0, 18, 8, 8, 20, 0, 1);// motor head
      cylinder (h = m8_nut_thick, r = m8_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
module gradient_cover()
{
    retainer_ht = 1.5;
    
    difference(){
        union(){
          cylinder (h = retainer_ht, r2 = 27.3, r1 = 26, $fn = 100);
          translate ([0, 0, retainer_ht]) cylinder (h = 7.5, r = 27.3, $fn = 100);
        }
        translate ([0, 0, retainer_ht]) cylinder (h = 11, r = 26, $fn = 100);
        // screw hole
        translate (-display_tolerance_z) cylinder (h = retainer_ht + 2 * display_tolerance, r = 4, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module gradient_support()
{
    gradient_pulley();
    translate ([0, 0, 9.5]) gradient_cover();    
}
//---------------------------------------------------------------------------
module gradient_support_with_screw(screw_length)
{
    gradient_support();
    M8_hexa(100);
}
//---------------------------------------------------------------------------

//gradient_support();

gradient_support_with_screw(100);