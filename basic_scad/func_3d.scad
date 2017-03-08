// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function semi_perimeter(l1, l2, l3) = (l1 + l2 + l3) / 2;

function area_heron(l1, l2, l3) = sqrt(semi_perimeter(l1, l2, l3) * (semi_perimeter(l1, l2, l3) - l1) * (semi_perimeter(l1, l2, l3) - l2) * (semi_perimeter(l1, l2, l3) - l3));