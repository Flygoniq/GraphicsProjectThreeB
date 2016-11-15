//  ******************* Tango dancer 3D 2016 ***********************
Boolean animating=true, stageTwo=false, PickedFocus=false, center=true, showViewer=false, showBalls=false, showCone=true, showCaplet=true, showImproved=true, solidBalls=false;
float t=0, s=0, f=0, maxf=4*30, angleChange;
pt origin, target; //origin is the point behind the dancer, target is where the dancer is going
pt right, left, memory;
vec front;
pt A, B, C;
int a, b, c;
char d;
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
  right = P.Pt(1);
  target = P(right.x, right.y, right.z);
  
  left = P.Pt(0);
  origin = P(left.x, left.y, left.z);
  front = V(P(left.x, left.y, left.z), P(right.x, right.y, right.z)).normalize();
  left = P(origin, -18, R(front));
  memory = P(origin, -18, R(front));
  right = P(target, 18, R(front));
  }

void draw() {
  background(255);
  pushMatrix();   // to ensure that we can restore the standard view before writing on the canvas
  setView();  // see pick tab
  showFloor(); // draws dance floor
  doPick(); // sets point Of and picks closest vertex to it in P (see pick Tab)
   
  // Steps shown as reg, green, blue disks on the floor 
  //pt A = P.Pt(0), B = P.Pt(1), C = P.Pt(2); //pt A is where the left foot starts, B is where the right foot starts, C is free
  //fill(grey);  showShadow(A,8);  showShadow(B,8); showShadow(C,8);
  fill(grey);
  for (int i = 0; i < P.nv; i++) {
    showShadow(P.Pt(i), 8);
  }

  //vec ForwardDirection = V(1,0,0);
  //front = V(origin, target).normalize();
  
  // Footprints shown as reg, green, blue disks on the floor
  
  if (stageTwo) {
    f++; if (f>maxf) {
      P.next();
      animating=true;
      f=0;
      A = P(B);
      B = P.Pt(P.pv);
      C = P.Pt(n(P.pv));
      angleChange = angle(V(B,A),V(B,C)) / maxf;
      if (P.pv % 2 == 1) angleChange = -1 * angleChange;
      println(angleChange);
    }
    t=(1.-cos(PI*f/maxf))/2;
    
    if(P.pv%2 == 0) {
      left = B;
      float angle = angle(V(B, A), V(B, C));
      vec V = R (V(B,C), angle, front, R(front));
      pt F1 = P(B, -15, U(V));
      pt F2 = P(B, 15, U(R(V(B,C))));
      if (d == 'b') {
        F2 = P(B, -15, U(R(V(B,C))));
      } else if (d == 's') {
        F2 = P(B, 15, U(V(B, C))); 
      }
      right = N(0, A, .45, F1, .55, F2, 1, C, t);
      float X = .5 + ((1/3) * abs(t - .5));
      showDancer(left, X, right, front);
      front = R(front, angleChange, front, R(front));
    } else {
      right = B;
      float angle = angle(V(B, A), V(B, C));
      vec V = R (V(B,C), angle, front, R(front));
      pt F1 = P(B, 15, U(V));
      pt F2 = P(B, -15, U(R(V(B,C))));
      if (d == 'b') {
        F2 = P(B, 15, U(R(V(B,C))));
      } else if (d == 's') {
        F2 = P(B, 15, U(V(B, C))); 
      }
      left = N(0, A, .45, F1, .55, F2, 1, C, t);
      float X = .5 + ((1/3) * abs(t - .5));
      showDancer(left, X, right, front);
      front = R(front, angleChange, front, R(front));
    }
  }
  
  if (!stageTwo && !animating) showDancer(right, s, left, front);  // THIS CALLS YOUR CODE IN TAB "Dancer"
  
  if (!stageTwo && animating) {
    if (t < 35) {//transfer
      showDancer(left, t / 35 + 1/3, right, front);
    }
    else if (t < 70) {//collect
      left = P(memory, (t - 35) / 35, V(memory, target));
      showDancer(left, t / 35 + 1/3, right, front);
    }
    else if (t < 85) {//rotate
      showDancer(left, 0, right, front);
      front = R(front, angleChange, front, R(front)); //use angleChange in second argument
    }
    else if (t < 120) {//aim
      left = P(memory, (t - 85) / 35, V(memory, target));
      showDancer(left, 0, right, front);
    }
    else {
      showDancer(left, 0, right, front);
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
      memory = P(left);
    }
    if (t == 150) {
      t = 0;
      right = P.Pt(1);
      target = P(right.x, right.y, right.z);
  
      left = P.Pt(0);
      origin = P(left.x, left.y, left.z);
      front = V(P(left.x, left.y, left.z), P(right.x, right.y, right.z)).normalize();
      left = P(origin, -18, R(front));
      memory = P(origin, -18, R(front));
      right = P(target, 18, R(front));
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
  