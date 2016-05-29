// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

module potentiometer()
{
    cylinder (h = 6.5, r= 9.5);
    
    translate ([0, 0, 6]) cylinder (h = 10, r = 5);
    translate ([0, 0, 16]) cylinder (h = 10, r = 3);
    
}

potentiometer();