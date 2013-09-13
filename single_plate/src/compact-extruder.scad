// PRUSA iteration3
// Compact extruder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <inc/PG35L.scad>;

dual_extruder = true;

with_vertical_carriage_holes = true;
with_mountplate_holes = false;

// supported hotends: jhead
// comment the line to disable
with_hotend_mount = "jhead";

// supported motors: PG35L
with_motor = "PG35L";

// increasing this value will elevate the motor so it can clear the x-ends.
motor_elevation = 5;

if(dual_extruder && with_mountplate_holes) {
	echo("can't use dual extruder with mountplate!");
}
else {
	extruder(vertical_carriage=with_vertical_carriage_holes, mounting_holes=with_mountplate_holes, hotend=with_hotend_mount);
	
	translate([19+25+2+6, -9, 8+3]) rotate([0,180,0]) idler();


	if(dual_extruder) translate([-7,-9, 0]) mirror([i,0,0])
		translate([0,0, 8+3]) rotate([0,180,0]) idler();
	
	// printed rods for the 608zz bearings.
	for(i=[1,2]) {
		*translate([-3,44+i*12-6,0]) cylinder(r=8/2,h=14);
		translate([6,44+i*12-6,0]) cylinder(r=8/2,h=14);
	}
}

///-

module motor() {

	PG35L(mini_hyena=true);
}


module nut(d,h,horizontal=true){
    cornerdiameter =  (d / 2) / cos (180 / 6);
    cylinder(h = h, r = cornerdiameter, $fn = 6);
    if(horizontal){
        for(i = [1:6]){
            rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
        }
    }
}

module bolt(length=10, d=3.3) {
	cylinder(r=d/2,h=length);
	translate([0,0,length]) cylinder(r=d*1.5/2,h=3);
}

module jhead_mount(second_extruder=false) {
   top_d=16;
   top_h=5;
   groove_d=12.3;
   groove_h=4.2;

   difference() {
	union() {
      translate([4,54-2,0]) cube([top_d+8,top_h+groove_h+2,24]);
      hull() {
        translate([2,54-5,14]) cube([top_d+12,top_h+groove_h+7,10]);
        translate([2,54-2,10]) cube([top_d+12,top_h+groove_h+2,14]);
      }
      translate([2,54-5,0]) cube([6,top_h+groove_h+5,23]);
     }
	 translate([1.5+11+3.5,54,11]) rotate([-90,0,0]) cylinder(r=groove_d/2+0.5, h=top_h+groove_h+1);
	 translate([1.5+11+3.5,54,11]) rotate([-90,0,0]) cylinder(r=top_d/2+0.5, h=top_h);
      hull() {
	    translate([1.5+11+3.5,54,11+(groove_d/2)+1]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2, h=top_h+groove_h+10);
	    translate([1.5+11+3.5,54,11+15]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2, h=top_h+groove_h+1);
      }
      hull() {
	    translate([1.5+11+3.5,54,11+(groove_d/2)-1]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
	    translate([1.5+11+3.5,54,11+15]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
      }
      hull() {
	    translate([1.5+11+3.5,54+top_h+groove_h,11+(groove_d/2)-6]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
	    translate([1.5+11+3.5,54+top_h+groove_h,11+15]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
      }

      translate([40,61,18.5]) rotate([0,-90,0]) bolt(length=40, d=3.6);
      translate([5.5,61,18.5]) rotate([0,-90,0]) cylinder(h=3.5, r=6/2);

	 translate([6,57,23-(36.5/2)]) rotate([0,-90,0]) union() {
	   translate([0,0,-4]) cylinder(r=3.5/2,h=10);
	   hull() {
	     translate([1,0,0]) nut(5.8, 3);
	     translate([-10,0,0]) nut(5.8, 3);
	   }
	 }
   }
}

module extruder_body(second_extruder=false) {
 // Main body
 translate([-2+2,0,0]) cube([24+6,58-9+motor_elevation,24]);

 *%translate([8,40,7]) rotate([0,-90,0]) bearing();

 translate([11-2+2+2+6, 22+1+4-1, 0]) {
  translate([11-1,13.5,12+1.5]) {
	cube([5,14,12-1.5]);
     translate([5+1,3.5,0]) cylinder(r=3.5, h=12-1.5);
  }
  if(second_extruder == false) translate([11,13,0]) {
	cube([5,8,12+1.5]);
     translate([5,4,0]) cylinder(r=4, h=12+1.5);
  }
 }
}

module extruder_holes(second_extruder=false) {
	translate([11+2,25-3+4,0]) {
		// Main shaft opening
		difference() {
			translate([5.5,0,-1]) cylinder(r=7.5, h=26);
			if(second_extruder) translate([9,-8,5.2]) cube([10,22,0.3]);
		}
	
		// Lower motor mount hole
		translate([5.5,21+0.5,0]) cylinder(r=2, h=3);
		// Lower motor mount hole screw head
		translate([5.5,21+0.5,1.5]) nut(5.8,22);
	
		difference() {
			union() {
				// Upper motor mount hole
				translate([5.5,-21+0.5,-10]) cylinder(r=2, h=34-20);
				// Upper motor mount hole screw head
				translate([5.5,-21+0.5,1.5]) nut(6,6);
			}
			if(second_extruder) translate([5.5,-21+0.5,-0.3]) translate([-3,-3,1.5]) cube([6,6,0.3]);
		}

		translate([6,-20,0]) difference() {
			translate([-5,-6,0]) cube([7.25,6,6]);
			cylinder(r=10/2,h=6);
		}
		
		// Idler bearing cutout
		translate([11+3+5,0,4]) cylinder(r=12, h=24);
	
		// hole for the detachable tab
		if(second_extruder == false) {
			translate([11-2+2+6,13.5+1-1,0]) {
				cube([5,7,12+1]);
				translate([5,3.5,0]) cylinder(r=3.5, h=12+1);
			}
		}
		translate([11+5-2+2+6,17+1-1,0]) translate([0,0,35]) rotate([0,180,0]) bolt(25, 3.7);
	}

	// remove material
	difference() {
		hull() for(x=[0,9]) {
			translate([x,0,0]) cylinder(r=10/2, h=30);
			translate([x,46+motor_elevation,0]) cylinder(r=10/2, h=30);
		}
	}
	difference() {
		hull() for(x=[-2,10+5]) {
			translate([x,21,0]) cylinder(r=10/2, h=25);
			translate([x,44,0]) cylinder(r=10/2, h=25);
		}
		difference() {
			translate([19,48,0]) cylinder(r=10/2, h=6);
			translate([11,47,4]) rotate([-45,0,-45]) cube([9,2,5]);
		}
	}
	translate([19,48,6]) rotate([0,-90,45]) translate([0,0,2]) cylinder(r=6/2, h=4);

	// Filament path
	translate([25,65+4,11]) rotate([90,0,0]) cylinder(r=4/2, h=70);

	difference() {
		union() {
			translate([5.5+5.8,-5+4,1.5]) cube([10,10-4,22]);
			translate([12+2+6,5+4,3+1]) tiltscrew();
		}
		difference() {
			translate([19,6,0]) intersection() {
				cylinder(r=10/2, h=6);
				translate([-5,-5,0]) cube([10,5,6]);
			}
			translate([12,3,3.5]) rotate([-35,0,-20]) translate([0,-2,-2]) cube([10,4,7]);
		}
	}
	translate([19,6,5]) rotate([0,-90,45+25]) translate([0,0,2]) cylinder(r=6/2, h=2);
}

module extruder_mount(second_extruder=false) {
  translate([18,29,0])
    hull() for(t=[16,-2])
      translate([t,24,0]) cylinder(r=5, h=24);

 if(!second_extruder) translate([37,54,0]) cube([8,25, 46]);
 *#translate([20,64,0]) cube([24, 20, 3]);
}

module extruder_mount_holes() {
if(dual_extruder) {

 if(second_extruder)
  translate([21,50,23]) rotate([0,90,0]) {
    // Carriage mount right screw head hole
    translate([-12,23,-1.5]) nut(5.8,23); //cylinder(r=7/2, h=23);
    // Carriage mount left screw head hole
    translate([12,23,-1.5]) nut(5.8,23); //cylinder(r=7/2, h=23);
    // Carriage mount right screw hole
    translate([-12,23,16]) cylinder(r=4/2, h=23);
    // Carriage mount left screw head hole
    translate([12,23,16]) cylinder(r=4/2, h=23);
  }

 difference() {
   translate([39,54,0]) cube([7,8, 44]);
   translate([37,54+8,0]) cylinder(r=8,h=44);
 }
 translate([20,84.2,0]) cylinder(r=17,h=10, $fn=4);

 translate([50,65,18.25]) rotate([0,-90,0]) nut(5.8, 13); //cylinder(h=15, r=6/2);

} else {

 *translate([dual_extruder?0:11+4+2+5,29,0]) {
  // Carriage mount right screw head hole
  translate([-12,24,-3]) cylinder(r=3.5, h=23);
  // Carriage mount left screw head hole
  translate([12,24,-3]) cylinder(r=3.5, h=23);
  // Carriage mount right screw hole
  translate([-12,24,20.5]) cylinder(r=2, h=23);
  // Carriage mount left screw head hole
  translate([12,24,20.5]) cylinder(r=2, h=23);
 }
}
}

module extruder_hotend(hotend=undef, second_extruder=false) {
 if(hotend == "jhead") {
   translate([2+2+5,4,0]) jhead_mount(second_extruder=second_extruder);
 }
}

module extruder_full(hotend=undef) {
  extruder_body();
  translate([18.5,26,0]) %rotate([180,0,90]) motor();
  translate([0,motor_elevation,0]) extruder_mount();
  translate([0,motor_elevation,0]) extruder_hotend(hotend);

  if(dual_extruder) translate([0,0,23*2]) mirror([0,0,1]) {
  	  extruder_body(second_extruder=true);
  	  translate([18.5,26,0]) %rotate([180,0,90]) motor();
	  translate([0,motor_elevation,0]) extruder_mount(second_extruder=true);
	  translate([0,motor_elevation,0]) extruder_hotend(hotend, second_extruder=true);
  }
}

module extruder_full_holes(){
  extruder_holes();
  if(dual_extruder) translate([0,0,23*2]) mirror([0,0,1]) extruder_holes(second_extruder=true);
  translate([0,motor_elevation,0]) {
	extruder_mount_holes(vertical_carriage, mounting_holes);
  	if(dual_extruder) translate([0,0,23*2]) mirror([0,0,1]) extruder_mount_holes(second_extruder=true);
  }
}

module tiltscrew() {
    for(r=[0:5:-30]) rotate([0,0,r])
      translate([-2,-15,0]) cube([3.4,20,7.4]);
    for(r=[0:5:-30]) rotate([0,0,r])
      translate([-10,0,7.4/2]) rotate([0,90,0]) cylinder(r=5/2,h=40);
}

module bearing() {
  difference() {
	rotate([0,90,0]) cylinder(r=22/2,h=8);
	rotate([0,90,0]) cylinder(r=8/2,h=8);
  }
}

module extruder_idler_base(bearing_indent){
 translate([0,10,3-0.5]) cube([19.5,34,8.5]);
 intersection() {
   translate([0,8,-(8)]) cube([19.5,36,8+3]);
   translate([0,25+5,6.1-bearing_indent]) rotate([0,90,0]) cylinder(r=16/2, h=19.5);
 }
 %translate([6,30,6]) bearing();
  translate([0,43,11]) rotate([0,90,0]) {
	translate([0,0,6-3]) cube([8.4,5,4.5+3]);
     translate([8.4/2,5,6-3]) cylinder(r=8.4/2, h=4.5+3);
  }
}

module extruder_idler_holes(bearing_indent){
 translate([10,25+5,0]){
  // Main cutout
  difference() {
    cube([10,23,25], center= true);
    translate([3.7,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r1=6, r2=10, h=2.6);
    translate([-6.3,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r1=10, r2=6, h=2.6);
  }
  // Idler shaft
  translate([-8,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r=4.1, h=16);
  hull() {
    translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
    translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
  }
 }

  hull() {
    translate([5,13,-1]) cylinder(r=5.5/2, h=15);
    translate([5,0,-1]) cylinder(r=5.5/2, h=15);
  }
  translate([0,48,11-8.4/2]) rotate([0,90,0]) bolt(25, 3.7);
  *translate([0,48,11-8.4/2]) rotate([0,90,0]) nut(6.5, 5);

  translate([-5,0,0]) hull() {
  	cube([30,16+2,4]);
  	translate([0,2.5+2,-4]) cube([30,16,4]);
  }
  translate([5,0,0]) cube([10,20,4]);
}

// Idler final part
module idler(bearing_indent=-1){
 difference(){
  extruder_idler_base(bearing_indent);
  extruder_idler_holes(bearing_indent);
 }
}

// Extruder final part
module extruder(hotend=undef){
 translate([0,0,0]) difference(){
  extruder_full(hotend=hotend);
  extruder_full_holes(hotend=hotend);
 }
 translate([20.5,15,20]) cube([2, 30, 6]);
}


