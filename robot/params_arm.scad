include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

unghi_umar = -0; // -180... 0
unghi_fore_arm = 90; // - 180 ... 0
unghi_cot = 180; // -90, 0
unghi_rotatie_gripper = 0;

   motor_housing_tolerance = 10;
   motor_housing_tolerance_large = 20;

bone_thick = 10;

distantor = 5;
grosime_tabla_alu = 3;

inaltime_roata_reductor_motor = 16;
inaltime_roata_reductor_ax = 16;

upper_arm_length = 270;
fore_arm_length = 300;

   lungime_tabla_umar = 90;
   latime_tabla_umar = 60;

   tabla_umar_sizes = [lungime_tabla_umar, latime_tabla_umar, grosime_tabla_alu];

   placa_trunchi_size = ([50, lungime_tabla_umar + 2 * distantor + 2 * rbearing_608_enclosed_housing_size[1], 3]);

pozitie_gauri_trunchi = [[-15.5, 0, 0], [15.5, 0, 0]];



   distanta_umar_trunchi = 140;
      dist_to_rotita_fore_arm = 12;
      
      perete_rulment_roata = 1.5;
      inaltime_roata_reductor_cot = bearing_4_height + 2 * perete_rulment_roata;