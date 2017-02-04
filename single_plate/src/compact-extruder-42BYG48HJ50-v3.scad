// PRUSA iteration3
// Compact extruder
// GNU GPL v3
// Author: EiNSTeiN_ <einstein@g3nius.org> (based on works by Josef Prusa <iam@josefprusa.cz>)
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <inc/42BYG48HJ50.scad>;
use <x-carriage.scad>;
use <inc/hexagon.scad>;
use <inc/fan25mm.scad>;
use <inc/angular-fan.scad>;
use <inc/LJ5A3.scad>;

// supported hotends: hexagon, dyzend
// comment the line to disable
with_hotend_mount = "hexagon";

// un-comment the desired view
//display(); // display extruder as it will be after a ssembly
print(); // full extruder ready to print

///-

module print() {
  // extruder body.
  translate([50,-2,0]) extruder(hotend=with_hotend_mount);

  // idler
  translate([140, 20-24, 11]) 
    rotate([0,180,90]) idler();

  // fan support
  translate([0, 0, 30])
  rotate([180, 0, 0])
  translate([90, -50, 0])
    fan_support(hotend=with_hotend_mount);

  // printed rods for the 608zz bearings.
  translate([70, -15, 0]) 
    cylinder(r=8/2, h=14, $fn=80);
  
  // fan hood
  translate([20, 5, 0]) fan_hood($fn=80);
  
  // hotend clamp
  translate([15, 45, 0]) hotend_clamp();
}

module display() {
  // extruder body.
  translate([-12, -body_height, 85+2+7]) 
    rotate([-90, 0, 0]) 
      extruder(hotend=with_hotend_mount);

  // fan support
  translate([-38/2, 0, 0]) rotate([90, 0, 0])
    fan_support(hotend=with_hotend_mount);

  // idler
  translate([-17, -body_height+20, 87+2+7]) 
    rotate([-90,0,0]) rotate([0,90,0]) idler();

  %translate([16, 0, 57]) 
    rotate([-90, 0, 0]) x_carriage();

  if(with_hotend_mount == "hexagon") {
    translate([0, -body_height/2, 41.5])
    %rotate([180, 0, -90]) hexagon();
  }
  
  translate([18, -30, 50/2-3])
    %rotate([90, 90, 0])
      angular_fan();
  
  // fan hood
  translate([10, -46, -12])
  #rotate([90, 0, 180]) fan_hood($fn=80);
  
  // hotend clamp
  #cylinder(r=17/2, h=4.5, $fn=80);
  
  // hotend clamp
  rotate([-90, 0, 0]) translate([109, 13, 0]) hotend_clamp();
}

///-

module hotend_clamp()
{
  height = 13.3;
  translate([0, -height, 0]) {
    difference() {
      union() {
        cylinder(r=17/2, h=4.5, $fn=80);
        translate([-17/2, 0, 0]) 
          cube([17, height, 4.5]);
      }
      translate([0, -6, -1])
        cylinder(r=12/2, h=4.5+2, $fn=80);
    }
  }
}

fan_holes_spacing = 57.5;
fan_holes_angle = 42;

module fan_hood()
{
  hole = 4.5;
  holes_spacing = fan_holes_spacing;
  bottom_y_distance = 7.5;
  bottom_x_distance = 47.5;
  hole_width = 17;
  hole_height = 13;
  elongation = 6;
  opening = 6;
  middle = 40;
  angle = fan_holes_angle;
  
  difference() {
    union() {
      cube([hole_width+2, opening+1+bottom_y_distance, 1]);
      cube([hole_width+2, 1, hole_height+2+elongation]);
      translate([0, opening-2, hole_height+2]) cube([hole_width+2, 3, elongation]);
      cube([1, opening+1, hole_height+2+elongation]);
      translate([hole_width+1, 0, 0]) cube([1, opening+1, hole_height+2+elongation]);
      
      hull() {
        translate([hole_width+2-8/2, opening+1+bottom_y_distance, 0]) cylinder(r=8/2, h=1);
        translate([hole_width+2-bottom_x_distance, opening+1+bottom_y_distance, 0]) rotate([0, 0, angle]) {
          cylinder(r=8/2, h=1);
          translate([holes_spacing, 0, 0]) cylinder(r=8/2, h=1);
        }
      }
      
      translate([0, 1, 1]) difference() {
        cube([hole_width+2, 12/2, 12/2]);
        translate([1, 12/2, 12/2]) rotate([0, 90, 0]) 
          cylinder(r=12/2, h=hole_width);
      }
    }
    union() {
      translate([hole_width+2-bottom_x_distance, opening+1+bottom_y_distance, -1]) rotate([0, 0, angle]) {
        cylinder(r=hole/2, h=1+2);
        translate([holes_spacing, 0, 0]) cylinder(r=hole/2, h=1+2);
        translate([holes_spacing/2, 0, 0]) cylinder(r=middle/2, h=1+2);
      }
    }
  }
}

module fan_support(hotend)
{
  difference() {
    union() {
      hull() for(x=[8, 30]) for(y=[7, 33])
        translate([x, y, 0]) 
          cylinder(r=8/2, h=30, $fn=80);
      
      translate([0, 32.6, 0])
        cube([38, 4.4, 30]);
      
      hull() {
        translate([16.5+40.5, 1.5+1, 26]) 
        rotate([0, 0, 180-fan_holes_angle]) {
          cylinder(r=10/2, h=4, $fn=60);
          translate([fan_holes_spacing, 0, 0]) cylinder(r=10/2, h=4, $fn=60);
        }
      }
      
      translate([33, 4, 6+9]) minkowski() {
        cube([14, 4, 12]);
        rotate([-90, 0, 0]) cylinder(r=1.5, h=1, $fn=80);
      }
      
      hull() for(x=[0, 24])
      translate([7+x, 36, 22]) hull() {
        cylinder(r=8/2, h=8, $fn=60);
        translate([0, 5, 0]) cylinder(r=8/2, h=8, $fn=60);
      }
    }
    union() {
      // angular fan top hole
      translate([16.5+40.5, 1.5+1, 26-1]) 
      rotate([0, 0, 180-fan_holes_angle]) {
        // angular fan bottom hole
        cylinder(r=4.25/2, h=4+2, $fn=60);
        translate([0, 0, -3])
          rotate([0, 0, 41]) 
          cylinder(r=7.9/2, h=4+2, $fn=6);
        
        // angular fan top hole
        translate([fan_holes_spacing, 0, 0]) {
          cylinder(r=4.25/2, h=4+2, $fn=60);
          translate([0, 0, -4])
            rotate([0, 0, 41]) 
            cylinder(r=7.9/2, h=5+2, $fn=6);
        }
      }
      
      // inside cutout
      hull() for(x=[8+3, 30-3]) for(y=[7+3, 33-4.5-1.5-3])
        translate([x, y, -1]) 
          cylinder(r=8/2, h=30+2, $fn=80);
      
      // 25mm fan holes
      translate([8, 18, 14])
        rotate([0, -90, 0])
          fan25mm_holes(3.5, $fn=80);
      translate([10, 18, 14])
        rotate([0, -90, 0])
          fan25mm_holes(6.25, 6-2, $fn=6);
      
      // hotend support collar
      hull() for(z=[0, 4])
        translate([19, 38, 11+z])
          rotate([90, 0, 0])
            cylinder(r=12/2, h=6, $fn=80);
      
      hull() for(z=[0, 6])
        translate([19, 38.6-6, 11+z])
          rotate([90, 0, 0])
            cylinder(r=18/2, h=6, $fn=80);
      
      // hotend insert cutout
      hull() for(z=[0, 14])
      translate([19, 37, 11+6+z])
        rotate([90, 0, 0])
          cylinder(r=17/2, h=4.5, $fn=80);
      
      translate([19, 37+10, 11+6])
        rotate([90, 0, 0])
        cylinder(r=17/2, h=12, $fn=80);
      
      // bottom hotend cutout
      hull() for(x=[12, 26], z=[6, 24]) 
        translate([x, 0, z])
          rotate([-90, 0, 0])
            cylinder(r=4/2, h=8, $fn=80);
      
      // right air cutout
      hull() translate([33.1+8, 18, 14])
        rotate([0, -90, 0])
          for(x=[-8, 10]) for(y=[-7, 8])
            translate([x, y, 0])
            cylinder(r=4/2, h=20, $fn=80);
      
      // back nut
      for(x=[7, 31])
      translate([x, 33, 10])
      rotate([0, 180, 90]) union() {
        translate([0,0,-1]) 
          cylinder(r=3.5/2,h=30, $fn=20);
        hull() {
          translate([0.5,0,0]) nut(5.3, 3);
          translate([-7,0,0]) nut(5.6, 3);
        }
      }
      
      // probe cutout
      hull() {
        translate([45-4.5, 3, 15+6])
          rotate([-90, 0, 0]) probe_cylinder(6);
        *translate([45+6, 4, 15-6])
          rotate([-90, 0, 0]) probe_cylinder(6);
      }
      
      // top extruder block holes
      for(x=[0, 24])
        translate([7+x, 36+5, 22-1]) 
          cylinder(r=3.5/2, h=6-0.1, $fn=60);
      for(x=[0, 24])
        translate([7+x, 36+5, 27]) 
          cylinder(r=6/2, h=3+1, $fn=60);
    }
  }
  
  translate([4, 18, 14])
    rotate([0, -90, 0])
      %fan25mm();
  
  translate([45-4.5, 4, 15+6])
    rotate([-90, 0, 0]) %probe(6, 5);
}

module motor() {
  %motor_42BYG48HJ50(mini_hyena=true);
}

module nut(d,h,horizontal=true){
  cornerdiameter = (d / 2) / cos(180 / 6);
  cylinder(h = h, r = cornerdiameter, $fn = 6);
  if(horizontal){
    for(i = [1:6]){
      rotate([0,0,60*i]) 
        translate([-cornerdiameter-0.2,0,0]) 
          rotate([0,0,-45]) cube([2,2,h]);
    }
  }
}

module bolt(length=10, d=3.3) {
  cylinder(r=d/2,h=length);
  translate([0,0,length]) cylinder(r=d*1.5/2,h=3);
}

body_height = 22;

module extruder_body(is_mirror) {
  // Main body
  translate([9,2,0]) 
    cube([21,66-18,body_height]);
  
  translate([6, 57-15, 0]) 
    cube([20, 15, body_height]);
  translate([-6,57-10+2.5,0]) 
      cube([25+11,7.5,body_height]);
  
  hull() {
    translate([1, 45, 0]) 
      cylinder(r=7/2, h=body_height, $fn=80);
    translate([10, 45, 0]) 
      cylinder(r=7/2, h=body_height, $fn=80);
    translate([1, 45+8, 0]) 
      cylinder(r=7/2, h=body_height, $fn=80);
  }
}

module extruder_holes(hotend=undef, is_mirror) {
  translate([13,25-3+4,0]) {
    difference() {
      // Main shaft opening
      translate([5.5,0,-1]) 
        cylinder(r=7, h=body_height+2, $fn=60);
      
      translate([6, -10, 16])
        cube([10, 20, 10]);
      
      translate([6, -5, 0])
        cube([1, 10, body_height-4]);
    }

    // Idler bearing cutout
    translate([-9, 2, 0]) cylinder(r=10, h=50, $fn=80);
    translate([-3, -0.5, 0]) cube([6, 6, body_height]);
  }

  // back nut
  translate([23.5,26-1,body_height-4]) rotate([0,0,180]) union() {
    translate([0,0,-1]) cylinder(r=3.5/2,h=10, $fn=20);
    hull() {
      translate([0.5,0,0]) nut(5.3, 3);
      translate([-7,0,0]) nut(5.6, 3);
    }
  }

  // Filament path
  translate([12,60,body_height/2]) rotate([90,0,0]) 
    cylinder(r=4/2, h=70, $fn=20);

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
    translate([23.5-4,12,19]) 
      rotate([0,180,0]) tiltscrew();
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
  
  // bottom nut inserts
  for(x=[0, 24])
  translate([x, 53, 3])
  rotate([0, 0, -90]) union() {
    translate([0,0,-7]) cylinder(r=3.5/2,h=15, $fn=20);
    hull() {
      translate([0.5,0,0]) nut(5.3, 3);
      translate([-7,0,0]) nut(5.6, 3);
    }
  }
  
  // idler 90 degree pivot cutout with minimal support
  translate([1, 45, body_height/2-8/2-1]) {
    difference() {
      hull() {
        cylinder(r=8.6/2, h=8, $fn=80);
        translate([-8, 0, 0]) cylinder(r=8.6/2, h=8.5, $fn=80);
        translate([0, -8, 0]) cylinder(r=8.6/2, h=8.5, $fn=80);
      }
      union() {
        translate([0, 0, 0])
          cylinder(r=4/2, h=8.5, $fn=80);
        intersection() {
          difference() {
            cylinder(r=7/2, h=8.5, $fn=80);
            cylinder(r=7/2-0.3, h=8.5, $fn=80);
          }
          translate([-7, -7, 0])
            cube([7, 7, body_height]);
        }
      }
    }
  }
  
  // idler pivot screw
  translate([1, 45, -1])
    cylinder(r=3.3/2, h=body_height + 2, $fn=80);
  translate([1, 45, body_height-4])
    cylinder(r=5.5/2, h=4 + 1, $fn=80);

  echo(hotend);
  // jhead recess
  if(hotend == "dyzend") {
    top_d=16; top_h=1.85;
    translate([16-4,57-top_h,body_height/2]) rotate([-90,0,0]) cylinder(r=top_d/2, h=top_h+1, $fn=60);
  }
  if(hotend == "jhead" || hotend == "hexagon") {
    top_d=16.5; top_h=5;
    translate([16-4,57-top_h,body_height/2]) rotate([-90,0,0]) cylinder(r=top_d/2, h=top_h+1, $fn=60);
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
  union() {
    for(r=[0:5:30]) rotate([0,0,-r])
        translate([-2,-15,0]) cube([3.4,20,7.4]);
    for(r=[0:5:30]) rotate([0,0,-r])
        translate([-10,0,7.4/2]) rotate([0,90,0]) cylinder(r=5/2,h=40, $fn=30);
  }
}

module bearing() {
  difference() {
    rotate([0,90,0]) cylinder(r=22/2,h=8);
    rotate([0,90,0]) cylinder(r=8/2,h=8);
  }
}

module extruder_idler_base(bearing_indent){
  translate([0,10,3]) cube([19.5,25+8,8]);
  
  hull() for(x=[0,10])
  translate([(19.5/2)-8/2,47-x,7]) rotate([0, 90, 0]) 
    cylinder(r=8/2, h=8, $fn=80);
  intersection() {
    translate([0,8,-8+2]) cube([19.5, 36, 13+4]);
    hull() for (z=[6.1-bearing_indent, 6.1]) 
      translate([0,25+5,z]) rotate([0,90,0]) cylinder(r=16/2, h=19.5);
  }
  hull() for(y=[15, -1]) translate([14,y,3]) 
    cylinder(r=3,h=8, $fn=30);

  translate([9,8,3]) difference() {
    cube([2,2,8]);
    translate([0,0,-1]) cylinder(r=2,h=10, $fn=30);
  }
  
  // bearing
  %translate([6,30,6]) bearing();
}

module extruder_idler_holes(bearing_indent){
  translate([10,25+5,0]){
    // Main cutout
    difference() {
      translate([0,0,6]) cube([10+0.4,23,25], center=true);
      translate([3.7,0,4.1+2-bearing_indent]) 
        rotate([0,90,0]) cylinder(r1=6, r2=10, h=1.3+1.3);
      translate([-5-1.3,0,4.1+2-bearing_indent]) 
        rotate([0,90,0]) cylinder(r1=10, r2=6, h=1.3+1.3);
    }
    // Idler shaft
    translate([-8,0,4.1+2-bearing_indent]) rotate([0,90,0]) cylinder(r=4.1, h=16);
    hull() {
      translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
      translate([-8,0,4.1+2+6-bearing_indent]) rotate([0,90,0]) cylinder(r=6, h=16);
    }
  }
  hull() {
    translate([4.5,13,-1]) cylinder(r=5.5/2, h=15, $fn=30);
    translate([4.5,0,-1]) cylinder(r=5.5/2, h=15, $fn=30);
  }
  translate([-4+9, 46,-5]) rotate([0,90,0]) bolt(25-9, 3.5, $fn=25);
  translate([-2,40,-6]) rotate([-50,0,0]) cube([10,10,10]);

  hull() {
    translate([20,16,3-1]) cylinder(r=3,h=10, $fn=30);
    translate([17,0,3-1]) cube([10,10,10]);
  }
  
  translate([(19.5/2)-8/2-1,47,7]) rotate([0, 90, 0]) 
    cylinder(r=3.3/2, h=8+2, $fn=80);
}

// Idler final part
module idler(bearing_indent=1)
{
  difference() {
    extruder_idler_base(bearing_indent);
    extruder_idler_holes(bearing_indent);
  }
}

// Extruder final part
module extruder(hotend=undef, is_mirror=false)
{
  difference() {
    extruder_full(hotend, is_mirror);
    extruder_full_holes(hotend, is_mirror);
  }
}
