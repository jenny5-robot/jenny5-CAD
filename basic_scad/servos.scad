// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <servos_params.scad>

include <tolerance.scad>

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

HS_7985MG();