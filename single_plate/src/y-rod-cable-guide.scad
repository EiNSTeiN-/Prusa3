large_dia = 19;
large_h = 8;
small_dia = 10;
small_h = 4;
wall = 4;
wire_dia = 5;

module under_cable_clip() {
  difference() {
    union() {
      cylinder(r=(large_dia/2)+wall, h=(large_h+small_h), $fn=120);
      translate([-large_dia/2-wall-5, -large_dia/2-wall, 0])
      cube([large_dia/2+wall+5, large_dia+wall*2, large_h+small_h]);
    }
    union() {
      translate([0, 0, small_h]) {
        cylinder(r=(large_dia/2), h=large_h+1, $fn=120);
        hull()
          for(x=[0, large_dia])
          translate([x, 0, 0])
          cylinder(r=(large_dia/2)-0.5, h=large_h+1, $fn=120);
      }
      translate([0, 0, -1]) {
        cylinder(r=(small_dia/2), h=small_h+2, $fn=120);
        hull()
          for(x=[0, large_dia])
          translate([x, 0, 0])
          cylinder(r=(small_dia/2)-0.5, h=small_h+2, $fn=120);
      }
      *translate([-large_dia/2-4-3, -large_dia/2-wall-1, 2])
        cube([6, large_dia+wall*2+2, 8]);
      *for(m=[0,1]) mirror([0, m, 0])
      translate([-large_dia/2-4-3, 0, -1])
        rotate([0, 0, -16]) cube([2, large_dia/2+wall+10, 8]);
      
      hull() for(z=[(large_h+small_h)/2, large_h+small_h])
      translate([-large_dia/2-wall, large_dia/2+wall+1, z])
        rotate([90, 0, 0]) 
        cylinder(r=wire_dia/2, h=large_dia+wall*2+2, $fn=80);
    }
  }
}

under_cable_clip();