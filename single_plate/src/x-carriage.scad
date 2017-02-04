// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>
use <inc/bearing.scad>

module x_carriage_base() {
 // Small bearing holder
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Long bearing holder
 translate([-33/2,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 // Base plate
 translate([-33,-11.5,0]) cube([33,68,8]);
 // sides
 translate([-33-26/2,-11.5-6,0]) cube([33+26,40+6,8]);
 // Belt holder blocks
 translate([-46,20-2-5.5-5,0]) cube([9,16+5,17]);
 translate([4,20-2-5.5-5,0]) cube([9,16+5,17]);
 for(x=[12,-12]) 
   hull() translate([-16.5+x,22,0]) 
   cylinder(r=12/2, h=17, $fn=80);
}

module x_carriage_beltcut() {
 // Cut in the middle for belt
 *translate([-2.5-16.5,16,7]) cube([4.5,14,8]);
 // Cut clearing space for the belt
 *translate([-38,5,7]) cube([40,13,15]);
 // Belt slit
 translate([-50,21.5+10-3,6]) cube([67,4,15]);
 *translate([-50,21.5-8.5,6]) cube([67,7-2.5,15]);
 // Smooth entrance
 *translate([-66,21.5+10,14]) rotate([45,0,0]) cube([67,15,15]);
 
 translate([-46,17,8]) cube([10,1.8,17]);
 translate([3,17,8]) cube([10,1.8,17]);
}

module x_carriage_holes() {
 // Small bearing holder holes cutter
 translate([-33/2,0,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
 // Long bearing holder holes cutter
 translate([-33/2,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Extruder mounting holes (screw holes and screw head)
 for(x=[12,-12],y=[0,36]) hull() translate([-16.5+x,22-y,-1]) cylinder(r=1.7, h=20, $fn=20);
 for(x=[12,-12],y=[0,36]) hull() for(y2=[0]) translate([-16.5+x,22-y-y2,8]) cylinder(r=3.5, h=20, $fn=30);
}

module x_carriage_fancy() {
 // Bottom right corner
 translate([0,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Top right corner
 translate([0,5,0]) translate([12,-11.5-6,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);
 // Top ĺeft corner
 translate([-33,5,0]) translate([-12,-11.5-6,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom left corner
 translate([-33,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);
 // Middle right corner
 translate([14,-34,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Middle left corner
 translate([-33-14,-34,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);
}

// Final part
module x_carriage() {
 difference() {
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
 }
}

x_carriage();
