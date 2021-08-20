
wheel_radius = 250;
wheel_internal_radius = 230;
wheel_thick = 30;

wheel_motor_radius = 125;
wheel_motor_length = 60;
wheel_motor_shaft_length = 100;
wheel_motor_shaft_radius = 12;

distance_between_legs = 400;

leg_lower_angle = -45;
leg_upper_angle = 45;

leg_bone_thick = wheel_thick + 20;
leg_bone_depth = 50; 
leg_upper_length = 500;

arm_bone_thick = 50;
arm_bone_depth = 50;
arm_length = 500;

fork_gap = 50;
fork_leg_radius = 15;
fork_base_length = 350;
fork_top_length = 200;
leg_lower_length = fork_base_length + fork_top_length;

knee_motor_radius = 107.5;
knee_motor_internal_radius = 42.5;
knee_motor_thick = 34; 

arm_angle = 70;

//---------------------------------------------
module knee_motor()
{
    difference(){
        color("Green") cylinder(r = knee_motor_radius, h = knee_motor_thick, center = true);
        cylinder(r = knee_motor_internal_radius, h = knee_motor_thick + 2, center = true);
    }
}
//---------------------------------------------
module wheel_motor_hub()
{
    color("black")
    cylinder(h = wheel_motor_length, r = wheel_motor_radius, center = true);
    cylinder(h = wheel_motor_shaft_length, r = wheel_motor_shaft_radius, center = true);
}
//---------------------------------------------
module wheel()
{
    difference(){
        color("LightSteelBlue") cylinder(r = wheel_radius, h = wheel_thick, center = true);
        cylinder(r = wheel_internal_radius, h = wheel_thick + 2, center = true);
    }
}
//---------------------------------------------
module wheel_with_motor()
{
    wheel();
    wheel_motor_hub();
}
//---------------------------------------------
module leg_upper_bone()
{
    color("gray")
    translate ([-leg_bone_depth / 2, -leg_bone_thick / 2, 0]) cube([leg_bone_depth, leg_bone_thick, leg_upper_length]);
}
//---------------------------------------------
module arm_bone()
{
    color("gray")
    translate ([-arm_bone_depth / 2, -arm_bone_thick / 2, 0]) cube([arm_bone_depth, arm_bone_thick, arm_length]);
}
//---------------------------------------------
module fork()
{
    color("grey") {
        translate ([0, -fork_gap, 0]) cylinder (h = fork_base_length, r = fork_leg_radius);
        translate ([0, fork_gap, 0]) cylinder (h = fork_base_length, r = fork_leg_radius);
        // connection
        translate ([-fork_leg_radius, -fork_gap - fork_leg_radius, fork_base_length]) 
            cube([2* fork_leg_radius, 2 * (fork_gap + fork_leg_radius), 20]);
        // top
        translate ([0, 0, fork_base_length]) cylinder (h = fork_top_length, r = fork_leg_radius);    
    }
}
//---------------------------------------------
module leg()
{
    // wheel
    rotate ([90, 0, 0]) {
        wheel_with_motor();
    }
    rotate([0, leg_lower_angle, 0]) fork();
    
    translate ([sin(leg_lower_angle) * leg_lower_length, fork_leg_radius + knee_motor_thick / 2, cos(leg_lower_angle) * leg_lower_length]) rotate ([90, 0, 0]) knee_motor();
    
    translate ([sin(leg_lower_angle) * leg_lower_length, fork_leg_radius + knee_motor_thick + leg_bone_thick / 2, cos(leg_lower_angle) * leg_lower_length]) rotate ([0, leg_upper_angle, 0]) leg_upper_bone();
}
//----------------------------------------------------------------
module legs()
{
    leg();
    translate ([0, distance_between_legs, 0]) mirror([0, 1, 0]) leg();
    
    
}
//----------------------------------------------------------------
module J5()
{
    legs();
    leg_heights = cos(leg_lower_angle) * leg_lower_length + cos(leg_upper_angle) * leg_upper_length;
    
    leg_delta_x = + sin(leg_lower_angle) * leg_lower_length + sin(leg_upper_angle) * leg_upper_length;
    
    // leg connector
    translate ([leg_delta_x, +knee_motor_thick + fork_leg_radius, leg_heights]) rotate([-90, 0, 0]) 
        color("grey") cylinder (h = distance_between_legs - 2 * knee_motor_thick - 2 * fork_leg_radius , r = 20);
    // arm
    
    // arm motor
    translate ([leg_delta_x, distance_between_legs / 2, leg_heights]) {
        rotate ([90, 0, 0]) knee_motor();
        rotate ([0, arm_angle, 0]) {
            translate ([0, 0, knee_motor_internal_radius]) arm_bone();
            translate ([0, 0, arm_length + knee_motor_internal_radius]) color("black") sphere(r = 50);
        }
    }
}
//----------------------------------------------------------------

J5();