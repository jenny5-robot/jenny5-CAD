// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

function rotate_x(angle, point) = [point[0] * cos(angle) - point[1] * sin(angle), point[0] * sin(angle) + point[1] * cos(angle), point[2]];
function rotate_y(angle, point) = [point[0] * cos(angle) - point[2] * sin(angle), point[1], point[0] * sin(angle) + point[2] * cos(angle)];
function rotate_z(angle, point) = [point[0] * cos(angle) - point[1] * sin(angle), point[0] * sin(angle) + point[1] * cos(angle), point[2]];

function mirror_x(point) = [-point[0], point[1], point[2]];
function mirror_y(point) = [point[0], -point[1], point[2]];
function mirror_z(point) = [point[0], point[1], -point[2]];