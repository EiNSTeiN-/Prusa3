thickness = 6.35;
width = 57;
height = 6;
wall = 3;
cable_dia = 10;
out_cable_dia = wall+cable_dia+wall;
tie_height = 3;

module back_cable_clip()
{
  difference() {
    union() {
      cube([wall, width, height]);
      
      translate([0, -wall, 0])
        cube([wall+thickness, wall, height]);
      translate([wall+thickness, -wall, 0])
        cube([wall, wall+wall, height]);
      translate([0, width, 0])
        cube([wall+wall, wall, height]);
      
      hull() {
        cube([wall, out_cable_dia, height]);
        translate([-out_cable_dia/2, out_cable_dia/2, 0])
          cylinder(r=out_cable_dia/2, h=height, $fn=80);
      }
    }
    union() {
      translate([-out_cable_dia/2, out_cable_dia/2, 0])
        cylinder(r=cable_dia/2, h=height, $fn=80);
      translate([-out_cable_dia/2+3, out_cable_dia/2, 0])
        rotate([0, 0, -45+180]) 
          cube([20,20,height]);
      
      translate([-out_cable_dia/2, out_cable_dia/2, height/2-tie_height/2]) {
        difference() {
          cylinder(r=out_cable_dia/2+2, h=tie_height, $fn=80);
          cylinder(r=out_cable_dia/2, h=tie_height, $fn=80);
        }
      }
    }
  }
}

back_cable_clip();