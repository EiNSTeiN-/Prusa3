
module rrd_switch()
{
  $fn=80;
  difference() {
    union() {
      cube([40, 16, 1.55]);
      translate([-13/2+(36-19/2), 16-6.55, 1.55])
        cube([13, 6.55, 5.5]);
    }
    union() {
      for(y=[-11/2, 11/2])
      translate([2.3, 16/2+y, -1])
        cylinder(r=3.3/2, h=4);
      
      translate([36, 16-3, -1])
        cylinder(r=3.3/2, h=4);
      translate([36-19, 16-3, -1])
        cylinder(r=3.3/2, h=4);
    }
  }
}

rrd_switch();