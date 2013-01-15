// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../../configuration.scad>
use <bearing.scad>
use <nuts_and_bolts.scad>

module x_end_base(){
// Main block
translate(v=[-14,-10-2,30]) cube(size = [17,39+4,60], center = true);
// Bearing holder
vertical_bearing_base();	
//Nut trap
 // Cube
 translate(v=[-2-2,-17,4]) cube(size = [8,16,8], center = true);
 // Hexagon
 translate(v=[0,-17,0]) rotate([0,0,30]) cylinder(h = 8, r=8, $fn = 6);
}

module x_end_holes(){
vertical_bearing_holes();
// Belt hole
translate(v=[-5.5-10+1.5,-10-4/2,30]) cube(size = [10,47-4,32], center = true);
// Bottom pushfit rod
translate(v=[-14,-40,6]) rotate(a=[-90,0,0]) pushfit_rod(9,50);
// Top pushfit rod
translate(v=[-14,-40,x_rod_distance+6]) rotate(a=[-90,0,0]) pushfit_rod(9,50);
// Nut trap
 translate(v=[0,-17,-1]) cylinder(h = 10, r=5.6/2);
 *translate(v=[0,-17,3]) rotate([0,0,30]) cylinder(h = 5, r=9.2/2, $fn = 6);
 translate(v=[0,-17,4]) rotate([0,0,30]) nutHole(5.2);
}


// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();


module pushfit_rod(diameter,length){
 cylinder(h = length, r=diameter/2, $fn=30);
 translate(v=[0,-diameter/4,length/2]) cube(size = [diameter,diameter/2,length], center = true);
 translate(v=[0,-diameter/2-1.3,length/2]) cube(size = [diameter,1,length], center = true);
}
