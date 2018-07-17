// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <../basic_scad/tolerance.scad>

//---------------------------------------------------------------------------
module motor_pulley_8mm_shaft()
{
  pulley_t_ht = 8;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){      
      union(){
      rotate ([0, 0, 13.5]) 
          pulley_with_shaft("HTD_5mm_pulley", 14, 0, 0, 10, 4, 0, 0);
        //pulley_with_shaft(51, 13, 0, 0, 8, 4, 0, 0);
          //pulley_with_shaft(57, 12, 0, 0, 8, 4, 0, 0);
          translate([-4, 3, 0]) cube([8, 2, 11]);
      }
     /*   
    // M3 screws
    translate ([0, 0, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_screw_radius, $fn = 25);
        
      dist_to_nut = 3;
    // M3 nut
    hull(){
            translate ([0, dist_to_nut - 1, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2 + 1, r = m3_nut_radius + 0.1, $fn = 6);
        //   translate ([0, dist_to_nut, 9 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
    }
      */

  }
}
//---------------------------------------------------------------------------
module motor_pulley_6mm_shaft()
{
  pulley_t_ht = 10;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){      
    //rotate ([0, 0, 10.8]) pulley_with_shaft(52, 14, 0, 0, 8, 4, 0, 0);
      union(){
        pulley_with_shaft("HTD_5mm_pulley", 12, 0, 0, pulley_t_ht, 3, 0, 0);
        translate([-4, 2, 0]) cube([8, 2, pulley_t_ht + 2 * pulley_base_height]);
      }
    // M3 screws
    translate ([0, 0, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_screw_radius, $fn = 25);
        
    // M3 nut
    hull(){
            translate ([0, 2 - 1, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2 + 1, r = m3_nut_radius + 0.1, $fn = 6);
       //    translate ([0, 5, 9 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
    }

  }
}
//---------------------------------------------------------------------------

motor_pulley_8mm_shaft();