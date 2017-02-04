dia = 6;
wall = 2;
thickness = 7;
arm_width = 11;
arm_length = 20;
t_length = 30;

$fn=80;

module cable_clip()
{
  difference() {
    y=wall+arm_width+wall;
    union() {
      cylinder(r=y/2, h=thickness);
      
      rotate([0, 0, -45])
        translate([0, -y/2, 0])
        cube([arm_length, y, thickness]);
      
      translate([-t_length, -thickness/2, 0])
        cube([t_length, thickness, thickness]);
      
      translate([-t_length, -thickness, 0])
        cube([wall, thickness*2, thickness]);
    }
    union() {
      translate([0, 0, -1])
        cylinder(r=(dia/2), h=thickness+2);
      
      translate([0, 0, wall])
        cylinder(r=arm_width/2, h=thickness);
      
      rotate([0, 0, -45])
        translate([0, -arm_width/2, wall])
        cube([arm_length+1, arm_width, thickness]);
    }
  }
}

cable_clip();