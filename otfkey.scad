$fn=64;

keyLength = 50;
keyWidth = 9;
keyThickness = 2;


wallWidth = 2;
bodyScalerX = 1.3;
bodyScalerY = 2;
bodyHeight = 8;

// knob dimensions

// movement dimensions
movementPlay = 10;

module key() {
    cube([keyLength,keyWidth,keyThickness],true);
}

module base() {
    difference() {
        union() {
            cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth,wallWidth],true);
            translate([0,bodyScalerY*keyWidth/2+wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth,bodyHeight],true);
            translate([0,-bodyScalerY*keyWidth/2-wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth,bodyHeight],true);
            translate([bodyScalerX*keyLength/2+wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
            translate([-bodyScalerX*keyLength/2-wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
        }
        translate([keyLength,0,wallWidth]) key();
    }
}

module latch() {
    
}

module keyHolder(insertKey) {
    color("red") union() {
        translate([0,-1,0])
            cube([8,keyWidth*bodyScalerY-2,2],true);
        translate([0,0,1])
            cylinder(5,2,2);
        translate([0,keyWidth*bodyScalerY/2-1,0])
            cube([4,2,2],true);
    }
    if(insertKey) {
        translate([keyLength/2+4,0,0]) color("white") key();
    }
}


module movement() {
    union() {
        difference() {
    cube([bodyScalerX*keyLength-movementPlay,bodyScalerY*keyWidth,wallWidth],true);
            cube([bodyScalerX*keyLength-movementPlay-2*wallWidth,4,1.1*wallWidth],true);
        }
        translate([14,5,wallWidth/2]) cylinder(3,2,2);
        translate([-14,5,wallWidth/2]) cylinder(3,2,2);
        translate([14,-5,wallWidth/2]) cylinder(3,2,2);
        translate([-14,-5,wallWidth/2]) cylinder(3,2,2);
        translate([14,-10,0]) cube([6,6,wallWidth],true);
    }
}

module rubberBand() {
    difference(){
        scale([1.05,1.05,1]) hull(){
            translate([14,5,wallWidth/2]) cylinder(3,2,2);
            translate([-14,5,wallWidth/2]) cylinder(3,2,2);
            translate([14,-5,wallWidth/2]) cylinder(3,2,2);
            translate([-14,-5,wallWidth/2]) cylinder(3,2,2);
            translate([-20.5,0,-1]) cylinder(5,2,2);
        }
        scale([1,1,2])translate([0,0,-1])hull(){
            translate([14,5,wallWidth/2]) cylinder(3,2,2);
            translate([-14,5,wallWidth/2]) cylinder(3,2,2);
            translate([14,-5,wallWidth/2]) cylinder(3,2,2);
            translate([-14,-5,wallWidth/2]) cylinder(3,2,2);
            translate([-20.5,0,-1]) cylinder(5,2,2);
        }
    }
}

module lid() {
    cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth,wallWidth],true);

}


module assembly(insertKey,keyOut) {
    translate([0,0,0]) base();
    if(keyOut) {
        translate([25,0,wallWidth]) keyHolder(insertKey);
    } else {
        translate([-20,0,wallWidth]) keyHolder(insertKey);
    }
    translate([2,0,2.1*wallWidth]) color("green", alpha=0.8) movement();
    translate([2,0,4]) color("yellow", alpha=0.7) rubberBand();
    translate([0,0,bodyHeight+wallWidth+0.1]) color("grey", alpha=0.2) lid();
}

translate([0,0,0]) assembly(true,false);
rotate([0,0,180]) mirror([0,0,1]) translate([0,0,0]) assembly(true,false);