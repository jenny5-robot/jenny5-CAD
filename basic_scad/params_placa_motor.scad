// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

placa_motor_trunchi_size = ([86, 42, 3]);

function f_placa_motor_holes(length, width)  = [
[0, 0, 0], 
[-(length / 2 - 11), - (width / 2 - 12), 0],
[-(length / 2 - 11), (width / 2 - 12), 0],
[(length / 2 - 11), - (width / 2 - 12), 0],
[(length / 2 - 11), (width / 2 - 12), 0]
];

pozitie_gauri_placa_motor = f_placa_motor_holes(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1]);