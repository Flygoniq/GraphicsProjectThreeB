//  ******************* Tango dancer 3D 2016 ***********************
Boolean animating=true, PickedFocus=false, center=true, showViewer=false, showBalls=false, showCone=true, showCaplet=true, showImproved=true, solidBalls=false;
float t=0, s=0, angleChange;
pt origin, target; //origin is the point behind the dancer, target is where the dancer is going
pt support, free, freemem;
vec front;
void setup() {
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  textureMode(NORMAL);          
  size(700, 700, P3D); // P3D means that we will do 3D graphics
  P.declare(); Q.declare(); PtQ.declare(); path.declare(); // P is a polyloop in 3D: declared in pts
  // P.resetOnCircle(3,100); Q.copyFrom(P); // use this to get started if no model exists on file: move points, save to file, comment this line
  P.loadPts("data/pts");  Q.loadPts("data/pts2"); // loads saved models from file (comment out if they do not exist yet)
  path.loadPts("data/dance path");
  noSmooth();
  frameRate(30);
  support = P.Pt(0);
  target = P(support.x, support.y, support.z);
  
  free = P.Pt(1);
  origin = P(free.x, free.y, free.z);
  front = V(P(free.x, free.y, free.z), P(support.x, support.y, support.z)).normalize();
  free = P(origin, -18, R(front));
  freemem = P(origin, -18, R(front));
  support = P(target, 18, R(front));
  println(d(P.Pt(0), P.Pt(1)));
  }

void draw() {
  background(255);
  pushMatrix();   // to ensure that we can restore the standard view before writing on the canvas
  setView();  // see pick tab
  showFloor(); // draws dance floor as yellow mat
  doPick(); // sets point Of and picks closest vertex to it in P (see pick Tab)
   
  // Footprints shown as reg, green, blue disks on the floor 
  pt A = P.Pt(0), B = P.Pt(1), C = P.Pt(2); //pt A is where the left foot starts, B is where the right foot starts, C is free
  fill(grey);  showShadow(A,20);  showShadow(B,14); showShadow(C,8);

  //vec ForwardDirection = V(1,0,0);
  //front = V(origin, target).normalize();
  
  // Footprints shown as reg, green, blue disks on the floor
  if (!animating) showDancer(support, s, free, front);  // THIS CALLS YOUR CODE IN TAB "Dancer"
  
  if (animating) {
    if (t < 35) {//transfer
      showDancer(free, t / 35 + 1/3, support, front);
    }
    else if (t < 70) {//collect
      free = P(freemem, (t - 35) / 35, V(freemem, target));
      showDancer(free, t / 35 + 1/3, support, front);
    }
    else if (t < 85) {//rotate
      showDancer(free, 0, support, front);
      front = R(front, angleChange, front, R(front)); //use angleChange in second argument
    }
    else if (t < 120) {//aim
      free = P(freemem, (t - 85) / 35, V(freemem, target));
      showDancer(free, 0, support, front);
    }
    else {
      showDancer(free, 0, support, front);
    }
    t++;
    if (t == 70) {
      origin = target;
      target = P(P.Pt(2));
      vec newFront = V(origin, target);
      angleChange = angle(front, newFront) / 15;
    }
    if (t == 85) {
      //free = P(target, -18, R(front));
      freemem = P(free);
    }
    if (t == 150) {
      t = 0;
      support = P.Pt(0);
      target = P(support.x, support.y, support.z);
  
      free = P.Pt(1);
      origin = P(free.x, free.y, free.z);
      front = V(P(free.x, free.y, free.z), P(support.x, support.y, support.z)).normalize();
      free = P(origin, -18, R(front));
      freemem = P(origin, -18, R(front));
      support = P(target, 18, R(front));
    }
    
  }



 //if(viewpoint) {Viewer = viewPoint(); viewpoint=false; showViewer=true;} // remember current viewpoint to shows viewer/floor frustum as part of the scene
     
 //if(showViewer) // shows viewer/floor frustum (toggled with ',')
 //    {
 //    noFill(); stroke(red); show(Viewer,P(200,200,0)); show(Viewer,P(200,-200,0)); show(Viewer,P(-200,200,0)); show(Viewer,P(-200,-200,0));
 //    noStroke(); fill(red,100); 
 //    show(Viewer,5); noFill();
 //    }
   
 
  popMatrix(); // done with 3D drawing. Restore front view for writing text on canvas

  // used for demos to show red circle when mouse/key is pressed and what key (disk may be hidden by the 3D model)
  if(keyPressed) {stroke(red); fill(white); ellipse(mouseX,mouseY,26,26); fill(red); text(key,mouseX-5,mouseY+4);}
     
  if(scribeText) {fill(black); displayHeader();} // dispalys header on canvas, including my face
  if(scribeText && !filming) displayFooter(); // shows menu at bottom, only if not filming
  //if (animating) { t+=PI/30; if(t>=TWO_PI) t=0; s=(cos(t)+1.)/2; } // periodic change of time 
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif");  // save next frame to make a movie
  change=false; // to avoid capturing frames when nothing happens (change is set uppn action)
  }
  