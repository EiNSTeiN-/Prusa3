// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>
use <inc/x-end.scad>

bearing_center = 5+(x_rod_distance/2);

module x_end_idler_base(){
 x_end_base();

   // The fake bearing
   %translate(v=[-5.5-(17/2)+(8/2),-25-2,bearing_center]) rotate(a=[0,-90,0]) cylinder(h = 8, r=(22/2)+2*0.66);

   // The two bumps around the center of the bearing
   translate([0,0,9+6]) rotate([0,180,0]) cylinder(r1=15/2, r2=12/2,h=1.5);
}

module x_end_idler_holes(){
 difference() {
   x_end_holes();
   translate(v=[-5.5-(17/2)+(8/2)+1+1,-25-2,bearing_center]) rotate(a=[0,-90,0]) cylinder(r1=15/2+1.5, r2=12/2,h=2);
   translate(v=[-5.5-17/2-8/2-1-1,-25-2,bearing_center]) rotate(a=[0,90,0]) cylinder(r1=15/2+1.5, r2=12/2,h=2);
}

 translate([-10,-21,11]) roundedcube([10,11,33], 4);
 translate([-25,-21,11]) roundedcube([10,27,33], 4);
 translate(v=[-5.5+1,-25-2,bearing_center]) rotate(a=[0,-90,0]) cylinder(h = 19, r=4.2, $fn=30);
}

// Final part
module x_end_idler(){
 mirror([0,1,0]) difference(){
  x_end_idler_base();
  x_end_idler_holes();
 }
}

x_end_idler();


