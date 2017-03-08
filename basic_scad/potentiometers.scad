// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_potentiometers.scad>

//--------------------------------------------------------------
module potentiometer_rectangular(base_length, base_width, base_height, base_shaft_radius, base_shaft_length, shaft_radius, shaft_length)
{
    color("blue") translate([- base_length / 2, - base_width / 2, 0])
        cube([base_length, base_width, base_height]);
    color("grey") translate ([0, 0, base_height]) cylinder (h = base_shaft_length, r = base_shaft_radius, $fn = 30);
    color("grey") translate ([0, 0, base_height + base_shaft_length]) cylinder (h = shaft_length, r = shaft_radius, $fn = 30);
}
//--------------------------------------------------------------
module potentiometer_circular(base_radius, base_height, base_shaft_radius, base_shaft_length, shaft_radius, shaft_length)
{
    color("blue") cylinder (r = base_radius, h = base_height);
    color("grey") translate ([0, 0, base_height]) cylinder (h = base_shaft_length, r = base_shaft_radius, $fn = 30);
    color("grey") translate ([0, 0, base_height + base_shaft_length]) cylinder (h = shaft_length, r = shaft_radius, $fn = 30);
}
//--------------------------------------------------------------
module potentiometer_92R1A_J22_L15L()
{
    potentiometer_rectangular(pot_92R1A_J22_L15L_base_length, pot_92R1A_J22_L15L_base_width, pot_92R1A_J22_L15L_base_height, pot_92R1A_J22_L15L_base_shaft_radius, pot_92R1A_J22_L15L_base_shaft_length, pot_92R1A_J22_L15L_shaft_radius, pot_92R1A_J22_L15L_shaft_length);
}

//--------------------------------------------------------------
module potentiometer_BOURNS_3852A_282_103AL()
{
    potentiometer_circular(pot_BOURNS_3852A_282_103AL_base_radius, pot_BOURNS_3852A_282_103AL_base_height, pot_BOURNS_3852A_282_103AL_base_shaft_radius, pot_BOURNS_3852A_282_103AL_base_shaft_length, pot_BOURNS_3852A_282_103AL_shaft_radius, pot_BOURNS_3852A_282_103AL_shaft_length);
}

//--------------------------------------------------------------
potentiometer_92R1A_J22_L15L();

//potentiometer_BOURNS_3852A_282_103AL();