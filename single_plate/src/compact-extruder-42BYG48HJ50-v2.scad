// PRUSA iteration3
// Compact extruder
// GNU GPL v3
// Author: EiNSTeiN_ <einstein@g3nius.org> (based on works by Josef Prusa <iam@josefprusa.cz>)
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <inc/42BYG48HJ50.scad>;

// supported hotends: jhead, dyzend
// comment the line to disable
with_hotend_mount = "dyzend";

/*

BOM:
-  2 x 608ZZ Bearing
- 15 x M3 nut
-  5 x M3 washers
-  4 x M3x6 screw
-  3 x M3x12 screw
-  4 x M3x16 screw
-  2 x M4 nut
-  2 x M4x25

*/

// un-comment the desired view
//display(); // display extruder as it will be after assembly
print(); // full extruder ready to print
//test(); // nut trap test


///-


module print() {
	// extruder body.
	for(i=[1]) mirror([i,0,0])
		translate([-0,-2,0]+i*[-74,-12,0]) extruder(hotend=with_hotend_mount, is_mirror=i);

	// idler
	*translate([60-7, 20-24, 11]) rotate([0,180,90]) idler();
	*translate([6, 20-44, 11]) rotate([0,180,90]) mirror([1,0,0]) idler();

	// printed rods for the 608zz bearings.
	*translate([55, 15, 0]) for(i=[0,1]) mirror([i,0,0])
		translate([4.5, 35, 0]+i*[0, 0, 0]) cylinder(r=8/2, h=14);

	*translate([5, -6, -65.2+4.2]) rotate([90,0,180]) union() {
		union() {
			translate([0,2,0]) extruder_hotend(with_hotend_mount);
			translate([0,2,52]) mirror([0,0,1]) extruder_hotend(with_hotend_mount);
		}
	}
}

module display() {
	// extruder body.
	translate([-6,0,0]) extruder(hotend=with_hotend_mount, is_mirror=0);
	translate([-6,0,43]) mirror([0,0,1]) extruder(hotend=with_hotend_mount, is_mirror=1);

	// idler
	translate([-10, -2, 19.5]) rotate([0,90,0]) idler();

	translate([-10,-4,-4.5]) {
		union() {
			translate([0,2,0]) extruder_hotend(with_hotend_mount);
			translate([0,2,6+46]) mirror([0,0,1]) extruder_hotend(with_hotend_mount);
		}
	}
}

// Use the test to verify nut traps!
module test() {
	intersection() {
		extruder(hotend=with_hotend_mount, is_mirror=i);
		#translate([18, 38, 0]) cube([26, 22, 20]);
	}
}

///-

module motor() {
	%motor_42BYG48HJ50(mini_hyena=true);
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

module jhead_mount(second_extruder=false, dyzend=false) {
   top_d=16;
   top_h=5;
   groove_d=12.3;
   groove_h=4.7;

   difference() {
	// body
	union() {
	
      translate([0,54,0]) {
		// main cube
		translate([-2,top_h,3/2+3]) cube([top_d+14+8,groove_h,24]);

		// rounded corner
		hull() {
			translate([3/2-2, top_h, 3/2+3]) rotate([-90,0,0]) cylinder(r=3/2, h=groove_h, $fn=20);
			translate([2+top_d+10-3/2+8, top_h, 3/2+3]) rotate([-90,0,0]) cylinder(r=3/2, h=groove_h, $fn=20);
		}

		if(!dyzend) hull() for(x=[3,10],y=[0,-10]) translate([x-3/2-2, 9, 3/2+3-y]) rotate([-90,0,0]) cylinder(r=3/2, h=groove_h, $fn=20);
	 }
     }
     translate([0,0,1.8]) union() {
		// filament path through the top
		translate([16,40,11]) rotate([-90,0,0]) cylinder(r=4/2, h=20, $fn=20);
		// j-head recess cutout
		hull() {
			translate([16,54,11]) rotate([-90,0,0]) cylinder(r=groove_d/2, h=top_h+groove_h+1);
			translate([16,54,0]) rotate([-90,0,0]) cylinder(r=groove_d/2, h=top_h+groove_h+1);
		}
		// create snap-fit for top part
     	hull() {
	    		translate([1.5+11+3.5,54-0.2,11+(groove_d/2)-1]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
	    		translate([1.5+11+3.5,54-0.2,11+15]) rotate([-90,0,0]) cylinder(r=(groove_d+4)/2+0.5, h=top_h);
      	}

		// fan nut trap
	 	if(!dyzend) translate([7.5-1,58+top_h,-3.5/2+52/2-36/2]) rotate([0,-90,0]) union() {
		   	translate([0,0,-4]) cylinder(r=3.8/2,h=20,$fn=20);
		   	hull() {
	     		translate([0.5,0,0]) nut(5.3, 3);
	    			translate([-5,0,0]) nut(5.6, 3);
	   		}
		}

		// bolt through body for attaching to extruder
		translate([13-9-2,58-10,10]) rotate([-90,-90,180]) {
	   		translate([0,0,-17-20]) cylinder(r=3.5/2,h=45, $fn=20);
		}
		translate([41-10,58,10-2]) rotate([-90,-90,180]) union() {
	  		translate([0,0,-17]) cylinder(r=3.5/2,h=25, $fn=20);
	   		translate([0,0,-17-25+10]) cylinder(r=7/2,h=25, $fn=20);
		}
	}

	translate([-5,60,24]) cube([50,20,6]);
   }
}

elongation = 0;

module extruder_body(is_mirror) {
	// Main body
	translate([9,2,0]) cube([21,66-9-2,52/2+4]);
	translate([8-15,57-10,0]) cube([44+5,10,13]);
	translate([10,57-9-36-1,0]) cube([36-4,10,18.5]);
	translate([8-15,57-10+3,0]) cube([33,7,20]);
}

module nicer_filament_path() {
	hull() {
		translate([12, 60, 8.5]) rotate([90,0,0]) translate([0,0,-1]) cylinder(r=6/2, h=33, $fn=30);
		translate([12, 60, 3]) rotate([90,0,0]) translate([0,0,-1]) cylinder(r=6/2, h=33, $fn=30);
	}
	translate([15, 60, 4]) difference() {
		rotate([90,0,0]) translate([0, 0, 0]) cube([2,2,33]);
		rotate([90,0,0]) translate([2, 2, 0]) cylinder(r=4/2, h=33, $fn=30);
	}
	translate([7, 60, 4]) difference() {
		rotate([90,0,0]) translate([0, 0, 0]) cube([2,2,33]);
		rotate([90,0,0]) translate([0, 2, 0]) cylinder(r=4/2, h=33, $fn=30);
	}
	translate([11,50,10.5]) hull() {
		cube([2,1,9.4]);
		translate([0,-14,0]) cube([2,14,1]);
	}
}

module extruder_holes(hotend=undef, is_mirror) {
	translate([13,25-3+4,0]) {
		// Main shaft opening
		translate([5.5,0,-1]) cylinder(r=7, h=50);
		
		// Idler bearing cutout
		translate([-9, 2, 0]) cylinder(r=10, h=50);

		translate([-3, -0.5, 0]) cube([6, 6, 20]);
	}

	// take out material between the screws holding the body to the hotends holder
	min=5+5;
	difference() {
		union() {
			hull() for(x=[4,20],z=[6,20]) translate([x,30,z]) rotate([-90,0,0]) cylinder(r=4/2,h=30-min, $fn=30);
			hull() for(x=[6,29],z=[12,20]) translate([x,42,z]) rotate([-90,0,0]) cylinder(r=4/2,h=20, $fn=30);
			hull() for(x=[-10,29],z=[14,20]) translate([x,42,z]) rotate([-90,0,0]) cylinder(r=4/2,h=20, $fn=30);
		}
		nicer_filament_path();
		translate([16-4,50,11-2.5]) rotate([-90,0,0]) cylinder(r=22/2+0.5, h=8);

	}
	
	difference() {
		hull() {
			translate([8, 52-9, 30]) rotate([0,90,0]) cylinder(r=10/2, h=22, $fn=30);
			translate([8, 25, 30]) rotate([0,90,0]) cylinder(r=10/2, h=22, $fn=30);
			translate([8, 52-9, 11]) rotate([0,90,0]) cylinder(r=10/2, h=22, $fn=30);
			translate([8, 25, 11]) rotate([0,90,0]) cylinder(r=10/2, h=22, $fn=30);
			translate([30,21,10]) cylinder(r=1,h=20, $fn=20);
		}
		// nicer filament path
		nicer_filament_path();
	}
	
	// Filament path
	translate([12,60,8.5]) rotate([90,0,0]) translate([0,0,-1]) cylinder(r=4/2, h=70, $fn=20);
	
	// cutout from the top of the idler tab
      translate([8,-1,18.5]) difference() {
        cube([24,34,20]);
        translate([0,3+(3*is_mirror),0]) difference() {
          cube([10,3,6]);
          translate([10/2,4,6/2]) rotate([90,0,0]) cylinder(r=3.5/2,h=10,$fn=30);
        }
      }

	// tiltscrew for idler
	union() {
		hull() {
			translate([22-3.2,-1-4,0]) cube([12,8,50]);
			translate([14-3.2,-4-4,0]) cube([12,1,50]);
		}
		hull() {
			translate([24-0.5,1,6]) cube([12,8,50]);
			translate([14-3.2,-4-4,6]) cube([12,1,50]);
		}
		translate([23.5-4,12,17.5]) rotate([0,180,0]) tiltscrew();
	}

	// holes for motors
	for(i=[0,36]) {
	 translate([26,8+i,2]) rotate([0,0,180]) union() {
	   translate([0,0,-7]) cylinder(r=3.5/2,h=10, $fn=20);
	   hull() {
	     translate([0.5,0,0]) nut(5.3, 3);
	     translate([-7,0,0]) nut(5.6, 3);
	   }
	 }
    }

	// hole for holding extruder body to hotends holder
	translate([12-14,49+5,12-4.5]) rotate([-90,-90,180]) union() {
	   translate([0,0,-12]) cylinder(r=3.5/2,h=20, $fn=30);
	   translate([0,0,-12-16]) cylinder(r=6/2,h=16, $fn=30);
	   hull() {
			translate([0.5,0,0]) nut(5.3, 3);
			translate([-6,0,0]) nut(5.6, 3);
	   }
	   hull() {
		translate([-13,-4,-1]) cube([5,8,5]);
		translate([-11,-3,1.5]) rotate([0,45,0]) cube([4,5.9,4]);
	   }
	   translate([-8,-4,0]) rotate([0,0,45]) cube([5.9,5.9,3]);
	   
	}
	translate([41-14,54,10-4.5]) rotate([-90,-90,180]) union() {
	   translate([0,0,-12]) cylinder(r=3.5/2, h=16, $fn=30);
	   translate([0,0,-12-16]) cylinder(r=6/2, h=16, $fn=30);
	   hull() {
			translate([0.5,0,0]) nut(5.3, 3);
			translate([-6,0,0]) nut(5.6, 3);
	   }
	   
	   hull() {
		translate([-11,-4,-1]) cube([5,8,5]);
		translate([-9,-3,1.5]) rotate([0,45,0]) cube([4,5.9,4]);
	   }
	   translate([-6,-4,0]) rotate([0,0,45]) cube([5.9,5.9,3]);
	   
	}

	// rounded corners
	translate([39,0,3]) difference() {
		translate([0,0,-3]) cube([3,80,3]);
		rotate([-90,0,0]) cylinder(r=6/2, h=80, $fn=30);
	}
	translate([12-15,50-9,4]) difference() {
		translate([-4,0,-4]) cube([4,20,4]);
		rotate([-90,0,0]) cylinder(r=8/2, h=20, $fn=30);
	}

	hull() {
		translate([49,67+elongation,30]) rotate([90,0,0]) cylinder(r=14/2,h=35+elongation);
		translate([49,67+elongation,27]) rotate([90,0,0]) cylinder(r=14/2,h=35+elongation);
		translate([9,67+elongation,30]) rotate([90,0,0]) cylinder(r=14/2,h=35+elongation);
		translate([9,67+elongation,27]) rotate([90,0,0]) cylinder(r=14/2,h=35+elongation);
	}

	// screws to hold the extruder to the x-carriage
	translate([38, 61-9, 10]) rotate([-90,0,90]) union() {
	  translate([0,0,-12]) cylinder(r=3.5/2,h=18, $fn=20);
        hull() {
          translate([0,0.5,0]) rotate([0,0,90]) nut(5.3, 3);
          translate([0,-5,0]) rotate([0,0,90]) nut(5.6, 3);
        }
        translate([0,2.5,0]) rotate([0,0,90]) {
          hull() {
            translate([-11,-4,-1]) cube([5,8,5]);
            translate([-9,-3,1.5]) rotate([0,45,0]) cube([4,5.9,4]);
          }
          translate([-6,-4,0]) rotate([0,0,45]) cube([5.9,5.9,3]);
        }
      }
      translate([38, 61-9-36, 10]) rotate([-90,0,90]) union() {
        translate([0,0,-12]) cylinder(r=3.5/2,h=18, $fn=20);
        hull() {
          translate([0,0.5,0]) rotate([0,0,90]) nut(5.3, 3);
          translate([0,-5,0]) rotate([0,0,90]) nut(5.6, 3);
        }
        translate([0,0.5,0]) rotate([0,0,90]) union() {
          hull() {
            translate([-11,-4,-1]) cube([5,8.4,5]);
            hull() for(z=[0,3]) translate([-9-z,-3,1.5]) rotate([0,45,0]) cube([4,5.9,4]);
          }
          hull() for(z=[0,3]) translate([-6-z,-4,0]) rotate([0,0,45]) cube([5.9,5.9,3]);
        }
      }
	
	// angle cut near the x-carriage screw 
	translate([30,5,19]) rotate([0,25,0]) cube([20,80,10]);

	echo(hotend);
	// jhead recess
	if(hotend == "dyzend") assign(top_d=16, top_h=1.85) {
		translate([16-4,57-top_h,11-2.5]) rotate([-90,0,0]) cylinder(r=top_d/2, h=top_h+1, $fn=60);
	}
	if(hotend == "jhead") assign(top_d=16.5, top_h=5) {
		translate([16-4,57-top_h,11-2.5]) rotate([-90,0,0]) cylinder(r=top_d/2, h=top_h+1, $fn=60);
	}
}

module extruder_hotend(hotend=undef, second_extruder=false) {
 if(hotend == "jhead") {
   jhead_mount(second_extruder);
 }
 if(hotend == "dyzend") {
   jhead_mount(second_extruder, dyzend=1);
 }
}

module extruder_full(hotend=undef, is_mirror=false) {
  extruder_body(is_mirror);
  translate([18.5-10,26,0]) %rotate([180,0,-90]) motor();
}

module extruder_full_holes(hotend=undef, is_mirror=false) {
  extruder_holes(hotend, is_mirror);
}

module tiltscrew() {
    for(r=[0:5:-30]) rotate([0,0,r])
      translate([-2,-15,0]) cube([3.4,20,7.4]);
    for(r=[0:5:-30]) rotate([0,0,r])
      translate([-10,0,7.4/2]) rotate([0,90,0]) cylinder(r=5/2,h=40, $fn=30);
}

module bearing() {
  difference() {
	rotate([0,90,0]) cylinder(r=22/2,h=8);
	rotate([0,90,0]) cylinder(r=8/2,h=8);
  }
}

module extruder_idler_base(bearing_indent){
	translate([0,10,3-0.5+2.5]) cube([19.5,25,6]);
	translate([0, 32+1, 6]) rotate([-50, 0, 0]) translate([0,-1.5,0]) cube([19.5, 21, 6]);
	intersection() {
		translate([0,8,-8+2]) cube([19.5, 36, 13+4]);
		hull() for (z=[6.1-bearing_indent, 6.1]) translate([0,25+5,z]) rotate([0,90,0]) cylinder(r=16/2, h=19.5);
 	}
	hull() for(y=[15, -1]) translate([14,y,3-0.5+2.5]) cylinder(r=3,h=6, $fn=30);

	translate([9,8,3-0.5+2.5]) difference() {
		cube([2,2,6]);
		translate([0,0,-1]) cylinder(r=2,h=8, $fn=30);
	}
	// bearing
	*%translate([6,30,6]) bearing();
}

module extruder_idler_holes(bearing_indent){
	translate([10,25+5,0]){
		// Main cutout
		difference() {
			translate([0,0,6]) cube([10+0.4,23,25], center=true);
			translate([3.7,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r1=6, r2=10, h=1.3+1.3);
			translate([-5-1.3,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r1=10, r2=6, h=1.3+1.3);
		}
		// Idler shaft
		translate([-8,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r=4.1, h=16);
		hull() {
			translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
			translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
		}
	}
	hull() {
		translate([5.5,13,-1]) cylinder(r=5.5/2, h=15, $fn=30);
		translate([5.5,0,-1]) cylinder(r=5.5/2, h=15, $fn=30);
	}
	translate([-4+9, 46,-5]) rotate([0,90,0]) bolt(25-9, 3.5, $fn=25);
	translate([-2,40,-6]) rotate([-50,0,0]) cube([10,10,10]);

	hull() {
		translate([20,16,3-0.5+2.5-1]) cylinder(r=3,h=10, $fn=30);
		translate([17,0,3-0.5+2.5-1]) cube([10,10,10]);
	}
}

// Idler final part
module idler(bearing_indent=1) {
	difference() {
		extruder_idler_base(bearing_indent);
		extruder_idler_holes(bearing_indent);
	}
}

// Extruder final part
module extruder(hotend=undef, is_mirror=false){
	echo(is_mirror);
	difference() {
		extruder_full(hotend, is_mirror);
		extruder_full_holes(hotend, is_mirror);
	}
}
