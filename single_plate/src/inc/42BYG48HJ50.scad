// Author: EiNSTeiN_ <einstein@g3nius.org>

module motor_42BYG48HJ50(mini_hyena=false) {

	cylinder(h=38,r=42/2);

	difference() {
		translate([-22,-22,0]) cube([44,44,1.2]);
		for(r=[0,90,180,270])
			rotate([0,0,r]) translate([-36/2,-36/2, 0]) cylinder(h=1.2,r=3.4/2);
	}

	translate([0,(-44/2)+11.5,-14]) cylinder(r=5/2,h=14);


	// mini hyena: H=10mm, ID=5mm, OD=12.5mm
	if(mini_hyena) translate([0,(-44/2)+11.5,-3]) rotate([180,0,0]) difference() {
		union() {
			cylinder(h=5.5,r=12.5/2);
			translate([0,0,5.5]) cylinder(h=2,r2=10.5/2, r1=12.5/2);
			translate([0,0,5.5+2]) cylinder(h=2, r2=12.5/2,r1=10.5/2);
			translate([0,0,9.5]) cylinder(h=0.5,r=12.5/2);
		}
		cylinder(h=10,r=5/2);
	}
}

motor_42BYG48HJ50(mini_hyena=true);