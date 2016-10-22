include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

angle_shoulder = -0; // -180... 0
angle_fore_arm = 90; // - 180 ... 0
angle_elbow = 270; // -90, 0
unghi_rotatie_gripper = 0;

bone_thick = 10;

grosime_tabla_alu = 3;

inaltime_roata_reductor_motor = 16;
inaltime_roata_reductor_ax = 16;

upper_arm_length = 270;
fore_arm_length = 300;

   lungime_tabla_umar = 50;
   latime_tabla_umar = 130;

   shoulder_plate_size = [lungime_tabla_umar, latime_tabla_umar, grosime_tabla_alu];

   plate_body_size = ([70, 60, 3]);


  
   dist_to_rotita_fore_arm = 12;
      
   perete_rulment_roata = 1.5;
   inaltime_roata_reductor_cot = bearing_4_height + 2 * perete_rulment_roata;
   
   upper_arm_motor_housing_shift = 15;