// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function semi_perimeter(l1, l2, l3) = (l1 + l2 + l3) / 2;

function area_heron(l1, l2, l3) = sqrt(semi_perimeter(l1, l2, l3) * (semi_perimeter(l1, l2, l3) - l1) * (semi_perimeter(l1, l2, l3) - l2) * (semi_perimeter(l1, l2, l3) - l3));