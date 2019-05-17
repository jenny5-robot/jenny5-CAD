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
    // body
    translate ([-1501MG_size[0] / 2, -1501MG_size[1] / 2, 0]) {
        color("black") cube(1501MG_size);
        //shaft
        color("Yellow") translate (1501MG_shaft_position) cylinder(h = 1501MG_shaft_length, r = 1501MG_shaft_radius);
        // round plate
        translate (1501MG_shaft_position + [0, 0, 1501MG_shaft_length - 2]) cylinder(h = 2, r = 1501MG_size[1] / 2);
        
    }
    // ears
    translate ([0, 0, 1501MG_screw_support_height]){
        difference(){
            color("black") translate([-1501MG_screw_support_size[0] / 2, - 1501MG_screw_support_size[1] / 2, 0])
    cube(1501MG_screw_support_size);
            // screw holes
            for (i = [0 : 3]){
                translate (1501MG_screw_holes_position[i] - display_tolerance_z)
                cylinder(h = 1501MG_screw_support_size[2] + 2 * display_tolerance, r = 2);
            } 
        }
    }
    
    
    
}
//-----------------------------------------------------------

//HS_7985MG();
power_hd_1501MG();