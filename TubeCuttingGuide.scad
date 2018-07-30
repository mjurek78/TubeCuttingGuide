//This is my first attempt at designing something in Open SCAD
//Designed by Marek Jurek
//////////////////////////////////////////////////

//Edit the parameter below to modify the outer diameter of your tube (default: 4mm)
TubeDiameter=4.0;
//Size of the blade opening (default: 1mm)
BladeOpeningWidth=1.0;

//Length of the guide
GuideLength=TubeDiameter*10.0;
// position of the opening from the side of the guide 
BladeOpeningMargin=TubeDiameter*2;

//don't edit the code below unless you know what you're doing
BoundingSquareDiagonal=TubeDiameter*sqrt(2);
NotchHeight=BoundingSquareDiagonal;
GuideHeight=(2*NotchHeight)/sqrt(2);
GuideWidth=2*GuideHeight;

module guide()
{
	difference(){
        // base of the guide
		cube([GuideLength,GuideWidth,GuideHeight]);
        
        // horizontal notch for the tube
        translate([0,GuideWidth/2,GuideHeight-NotchHeight]) {    
            rotate(a=45, v=[1,0,0]) {
                cube([GuideLength,GuideHeight,GuideHeight]);
            }
            //Uncomment line below if you want to visualize tube inside the notch
            //#tube();
        }
        
        // blade opening
        translate([BladeOpeningMargin,0,GuideHeight-NotchHeight]) {
            cube([BladeOpeningWidth,GuideWidth,GuideHeight]);
        }
	}
}

// tube for debug purposes
module tube() {
    translate([0,0,BoundingSquareDiagonal/2]) {
        rotate(a=90, v=[0,1,0]) {
            cylinder(GuideLength,d=TubeDiameter,$fs=TubeDiameter/32);
        }
    }
}

guide();