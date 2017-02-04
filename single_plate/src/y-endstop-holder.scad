use <inc/rrd-switch.scad>;

module y_clip() {

  thickness = 10;
  rod = 10;
  length = 30;

  difference() {
    union() {
      cylinder(r=9, h=thickness, $fn=30);
      
      translate([-18/2, -18-9, 0])
        cube([7, 18+9, thickness]);
      
      translate([-18/2-3, -18-9, 0])
        cube([16, 3, 26]);
    }
    union() {
      translate([0, 0, -1]) cylinder(r=rod/2, h=thickness+2, $fn=30);
      translate([0, -(rod - 1) / 2, 0]) cube([10, rod - 1, thickness]);
      translate([(rod / 2) - 1, -15, -1]) cube([10, 30, thickness+2]);
      
      translate([6+2-7, -20, 3])
        rotate([90, 0, 0])
        cylinder(r=3.3/2, h=10, $fn=80);
      translate([6+2-7, -20, 3+19])
        rotate([90, 0, 0])
        cylinder(r=3.3/2, h=10, $fn=80);
      
      translate([2-7, -27, 0])
        cylinder(r=3.3/2, h=30, $fn=80);
    }
  }

  translate([2, -9, 0]) difference() {
    hull() {
      translate(v = [-2,10-1,0]) cylinder(h = 10, r=9);
      translate(v = [-2,30+1,0]) cylinder(h = 10, r=9);
    }
    translate(v = [-2,10-1,-1]) cylinder(r=rod/2, h=thickness+2, $fn=30);	
    translate(v = [-2,30+1,-1]) cylinder(r=rod/2, h=thickness+2, $fn=30);
    translate([0,-8,-1]) cube([10,40,10+2]);
    translate([-7,-10,-1]) cube([10,40,10+2]);
  }
  
  translate([-12, -27, 39])
    rotate([90, 90, 0])
      %rrd_switch();
}

y_clip();

module x_clip() {
  thickness = 20;
  rod = 8.3;
  holes_distance = 19; // between the two screw holes on the switch.
  slit_height = 4;
  
  difference() {
    union() {
      translate([-3-rod/2,-(holes_distance+6)/2,0]) cube([4, holes_distance+6, thickness]);
      cylinder(r=rod/2 + 2, h=thickness);
    }
    cylinder(r=rod/2, h=thickness);
    translate([0,0,thickness-6]) difference() {
      cylinder(r=rod/2 + 4, h=slit_height);
      cylinder(r=rod/2 + 2, h=slit_height);
    }
    translate([0, -(rod - 1) / 2, 0]) cube([10, rod - 1, thickness]);
    translate([(rod / 2) - 1, -(rod + 4) / 2, 0]) cube([10, rod + 4, thickness]);

    for(i=[-1,1]) translate([-20,i*(holes_distance/2),4]) rotate([0,90,0]) cylinder(r = 4/2, h = 20);
    translate([-11,-15,9]) rotate([0,45,0]) cube([4,30,4]);
  }
}

*x_clip();

module z_clip() {
  thickness = 30;
  rod = 8.3;
  holes_distance = 19; // between the two screw holes on the switch.
  slit_height = 4;
  
  difference() {
    union() {
      translate([-3-rod/2,-(holes_distance+6)/2,0]) cube([4, holes_distance+6, thickness]);
      cylinder(r=rod/2 + 2, h=thickness);
    }
    cylinder(r=rod/2, h=thickness);
    #for(z=[thickness/2-slit_height/2, thickness-6]) translate([0,0,z]) difference() {
      cylinder(r=rod/2 + 4, h=slit_height);
      cylinder(r=rod/2 + 2, h=slit_height);
    }
    translate([0, -(rod - 1) / 2, 0]) cube([10, rod - 1, thickness]);
    translate([(rod / 2) - 1, -(rod + 4) / 2, 0]) cube([10, rod + 4, thickness]);

    for(i=[-1,1]) translate([-20,i*(holes_distance/2),4]) rotate([0,90,0]) cylinder(r = 4/2, h = 20);
    translate([-11,-15,9]) rotate([0,45,0]) cube([4,30,4]);
  }
}

*z_clip();


module z_cap() {
	difference() {
		cylinder(r=6/2,h=7, $fn=30);
		translate([0,0,2]) cylinder(r=3/2, h=7, $fn=30);
	}
	cylinder(r=12/2,h=2, $fn=30);
}

*z_cap();
