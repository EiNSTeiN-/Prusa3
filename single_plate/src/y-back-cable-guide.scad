
module bed_cable_clip() {

  thickness = 10;
  rod = 10;
  length = 30;

  *cylinder(r=11, h=thickness, $fn=30);
  difference() {
    cylinder(r=9, h=thickness, $fn=30);
    cylinder(r=rod/2, h=thickness+2, $fn=30);
    translate([0, -(rod - 1) / 2, 0]) cube([10, rod - 1, thickness]);
    translate([(rod / 2) - 1, -15, 0]) cube([10, 30, thickness]);
  }

  translate([2, -9, 0]) difference() {
    hull() {
      translate(v = [-2,10-1,0]) cylinder(h = 10, r=9);
      translate(v = [-2,30+1,0]) cylinder(h = 10, r=9);
    }
    translate(v = [-2,10-1,-1]) cylinder(r=rod/2, h=thickness+2, $fn=30);	
    translate(v = [-2,30+1,-1]) cylinder(r=rod/2, h=thickness+2, $fn=30);
    translate([0,-8,0]) cube([10,40,10]);
    translate([-7,-10,0]) cube([10,40,10]);
  }

  difference() {
    translate([-length-rod/2, -8/2, 0]) cube([length, 8, 5]);
    hull() for(i=[0:4]) translate([-length-rod/2+3+(i*5)+1,0,0]) cylinder(r=4/2, h=6, $fn=20);
  }
}

bed_cable_clip();
