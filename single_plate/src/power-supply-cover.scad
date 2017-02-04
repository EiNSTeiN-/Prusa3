width = 114;
height = 50;
overhead = 17;
inside_depth = 35;
holes = 33;
holes_distance = 50;
side_hole = 38;
wall = 2;

socket_width = 39;
socket_height = 28;

m10_distance = 150;
m10_dia = 10.5;
m10_height = 40;
m10_z_distance = 20;
m10_depth = 20;

module cover()
{
  difference() {
    union() {
      translate([-(width/2+wall), 0, 0])
        cube([width+wall, wall*2+height, wall + inside_depth + holes + 6]);
      
      translate([-m10_distance+(width/2)-8,0,0])
        cube([m10_distance+8, m10_depth, m10_height]);
    }
    union() {
      translate([-(width/2-wall), wall, wall])
        cube([width-wall*2, height, wall + inside_depth + holes + 6]);
      
      translate([-width/2, wall, wall + inside_depth])
        cube([width+1, height, holes + 6 + 1]);
      translate([-width/2, -1, wall + inside_depth + overhead])
        cube([width+1, height, holes + 6]);
      
      translate([width/4, height+wall/2, inside_depth/2+wall]) hull() {
        translate([-socket_width/2, 0, -24/2]) cube([socket_width, 6, 24]);
        translate([-35/2, 0, -socket_height/2])
        cube([35, 6, socket_height]);
      }
      
      for(x=[1,-1])
      translate([x*(holes_distance/2), wall*2+1+height, wall+inside_depth+holes]) rotate([90,0,0])
        cylinder(r=4.2/2, h=10, $fn=80);
      
      translate([-width/2,wall+side_hole,wall+inside_depth+holes])
      rotate([0,-90,0])
        cylinder(r=4.2/2, h=10, $fn=80);
      
      translate([-(width/2+wall+1), 0, wall+inside_depth+overhead-1])
        rotate([30, 0, 0]) cube([wall+2+width, 50, 30]);
      
      for(z=[1,-1])
      translate([(width/2)-m10_distance, -1, m10_height/2+z*(m10_z_distance/2)]) 
        rotate([-90, 0, 0])
          cylinder(r=m10_dia/2, h=height+wall*2+2, $fn=80);
      
      for(x2=[5, 15, 25])
        translate([-width/2+x2, -1, 0])
          hull() translate([0, 0, wall+3/2])
            for(x=[0, 3]) translate([x, 0, 0])
              rotate([-90, 0, 0]) 
                cylinder(r=3/2, h=wall+2, $fn=80);
    }
  }
}

cover();
