// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <servos_params.scad>

include <tolerance.scad>

//-----------------------------------------------------------
module HS_7985MG()
{
    translate ([-HS_7985MG_size[0] / 2, -HS_7985MG_size[1] / 2, 0]) cube(HS_7985MG_size);
    translate ([0, 0, HS_7985MG_screw_support_height]){
        difference(){
            translate([-HS_7985MG_screw_support_size[0] / 2, - HS_7985MG_screw_support_size[1] / 2, 0])
    cube(HS_7985MG_screw_support_size);
            for (i = [0: 3]){
                translate (HS_7985MG_screw_holes_position[i] - display_tolerance_z)
                cylinder(h = HS_7985MG_screw_support_size[2] + 2 * display_tolerance, r = 2);
            } 
        }
    }
}
//-----------------------------------------------------------
module power_hd_1501MG()
{
    translate ([-1501MG_size[0] / 2, -1501MG_size[1] / 2, 0]) cube(1501MG_size);
    translate ([0, 0, 1501MG_screw_support_height]){
        difference(){
            translate([-1501MG_screw_support_size[0] / 2, - 1501MG_screw_support_size[1] / 2, 0])
    cube(1501MG_screw_support_size);
            for (i = [0: 3]){
                translate (1501MG_screw_holes_position[i] - display_tolerance_z)
                cylinder(h = 1501MG_screw_support_size[2] + 2 * display_tolerance, r = 2);
            } 
        }
    }
}
//-----------------------------------------------------------

//HS_7985MG();
power_hd_1501MG();