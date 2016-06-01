include <params_laptop.scad>

module laptop13(lid_angle = 10)
{
    color ("white") cube(laptop13_size);
    color ("white") translate ([0, 0, laptop13_size[2] + 1]) rotate ([lid_angle, 0, 0]) cube([laptop13_size[0], laptop13_size[1], 3]);
}

laptop13(10);