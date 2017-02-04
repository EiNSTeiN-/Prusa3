
// author: EiNSTeiN_ <einstein@g3nius.org>
// print with flexible material such as NinjaFlex

module corner_pad() {

	difference() {
		translate([0,-15,0]) cube([50,30,22]);
		translate([-37.5/2+25,0,20]) rotate([0,90,0]) cylinder(r=18/2,h=37.5);
		translate([-1,0,20]) rotate([0,90,0]) cylinder(r=10/2,h=60);
		translate([14.01,0,20]) rotate([0,90,0]) cylinder(r=20/2,h=2);
		translate([33.99,0,20]) rotate([0,90,0]) cylinder(r=20/2,h=2);
		translate([-9+25,-11,11]) cube([18,22,30]);
	}
	
}

//corner_pad();


module frame_pad() {

	difference() {
		hull() {
			translate([-25,-18/2,0]) cube([50,18,22]);
			translate([-30,-28/2,0]) cube([60,28,4]);
		}
		*translate([-37.5/2+25,0,20]) rotate([0,90,0]) cylinder(r=18/2,h=37.5);
		*translate([-1,0,20]) rotate([0,90,0]) cylinder(r=10/2,h=60);
		*translate([14.01,0,20]) rotate([0,90,0]) cylinder(r=20/2,h=2);
		*translate([33.99,0,20]) rotate([0,90,0]) cylinder(r=20/2,h=2);
		#translate([-5-25,-6/2,12]) cube([60,6,30]);
	}
	
}

//frame_pad();

