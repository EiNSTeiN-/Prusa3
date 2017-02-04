width = 130;
height = 50;
extra_bottom_distance = 18; // space at the bottom for rrd fan extender
depth = 76;
holes = 33;
holes_distance = 50;
side_hole = 38;
wall = 4;

socket_width = 39;
socket_height = 28;

m10_distance = 150;
m10_dia = 10.5;
m10_height = 40;
m10_z_distance = 20;
m10_depth = 20;

connector_holes = 6;
connector_length = 25;

module arduino()
{
  difference() {
    union() {
      // main box
      translate([-(width/2+wall), 0, 0])
        cube([width+wall*2, wall*2+height, wall + extra_bottom_distance + depth]);
      
      // front plate
      translate([-(width/2+wall), -wall, 0])
        cube([width+wall*2, wall, wall*2+connector_holes+1]);
      
      // rod backing
      translate([(width/2+wall),height-m10_depth+wall*2,0]) mirror([1, 0, 0])
        cube([m10_distance+8, m10_depth, m10_height]);
    }
    union() {
      // internal cutout
      translate([-(width/2), -0.01, wall])
        cube([width, height + wall, extra_bottom_distance + depth + 1]);
      
      // 45 degree cutout
      translate([-(width/2+wall+1), 0, wall+extra_bottom_distance+depth-40])
        rotate([45, 0, 0]) cube([width+wall*2+2, 60, 30]);
      
      // m10 rod holes
      for(z=[1,-1])
        translate([(width/2+wall)-m10_distance, -1, m10_height/2+z*(m10_z_distance/2)]) 
          rotate([-90, 0, 0])
            cylinder(r=m10_dia/2, h=height+wall*2+2, $fn=80);
      
      // back slots
      for(h=[1, depth+extra_bottom_distance-connector_holes-1]) translate([0, 0, h])
        for(m=[0, 1]) mirror([m, 0, 0])
          for(x2=[5, 32])
            translate([-width/2+x2, height+wall-1, 0])
              hull() translate([0, 0, wall+connector_holes/2])
                for(x=[0, connector_length-connector_holes]) translate([x, 0, 0])
                  rotate([-90, 0, 0]) 
                    cylinder(r=connector_holes/2, h=wall+2, $fn=80);
    
      // front slots
      for(m=[0, 1]) mirror([m, 0, 0])
        for(x2=[5, 32])
          translate([-width/2+x2, -wall-1, 0])
            hull() translate([0, 0, wall+6/2+1])
              for(x=[0, connector_length-connector_holes]) translate([x, 0, 0])
                rotate([-90, 0, 0]) 
                  cylinder(r=connector_holes/2, h=wall+2, $fn=80);
    
      // USB cable opening
      translate([-width/2-wall, 0, m10_height+10]) hull() {
        rotate([0, 90, 0])
        translate([0, height-5, 0])
          hull() for(x=[2.5+5, 0])
            translate([-x*5, 0, 0])
              hull() for(y=[1, -1])
                translate([0, y*3, -1])
                  cylinder(r=8/2, h=wall+2, $fn=80);
        rotate([0, 90, 0])
        translate([0, height-5, 0])
          hull() for(x=[1+4.75, 0])
            translate([-x*5, 0, 0])
              hull() for(y=[1, -4])
                translate([0, y*3, -1])
                  cylinder(r=8/2, h=wall+2, $fn=80);
      }
      
      // side angled slots above USB
      for(d=[0])
      translate([-width/2-wall, d-20, m10_height+10+d]) {
        rotate([0, 90, 0])
        translate([-3.5*5, height-11, -1])
          cylinder(r=8/2, h=wall+2, $fn=80);
        rotate([0, 90, 0])
          translate([-5-2, height-5-6*3+2, -1])
            cylinder(r=8/2, h=wall+2, $fn=80);
      }
      
      // 3mm side screws
      for(y=[height, wall])
        for(z=[wall+6, depth/2, depth+wall-6])
          translate([width/2-1, y, z])
            rotate([0, 90, 0])
              cylinder(r=4.5/2, h=wall+2, $fn=60);
      
      // https://www.safaribooksonline.com/library/view/arduino-a-technical/9781491934319/assets/aian_0406.png
      translate([-32-15, height+wall+wall+1, depth+extra_bottom_distance-60]) 
      rotate([-90, -90, 180]) {
        // bottom left
        translate([50.8, -15.24, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
        // bottom right
        translate([2.54, -13.97, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
        // middle right
        translate([7.62, -66.04, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
        // middle left
        translate([7.62+27.9, -66.04, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
        // top left
        translate([50.8, -90.17, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
        // top right
        translate([2.54, -96.52, 0])
          cylinder(r=3.2/2, h=wall+2, $fn=60);
      }
    }
  }
}

arduino();
