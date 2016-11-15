void keyPressed() 
  {
  if(key=='`') picking=true; 
  if(key=='?') scribeText=!scribeText;
  if(key=='!') snapPicture();
  if(key=='~') filming=!filming;
  if(key=='i') showImproved=!showImproved;
  if(key==']') showBalls=!showBalls;
  if(key=='C') showCaplet=!showCaplet;
  if(key=='K') showCone=!showCone;;
  if(key=='q') Q.copyFrom(P);
  if(key=='p') P.copyFrom(Q);
  if(key=='e') {PtQ.copyFrom(Q);Q.copyFrom(P);P.copyFrom(PtQ);}
  if(key=='c') center=!center; // snaps focus F to the selected vertex of P (easier to rotate and zoom while keeping it in center)
  if(key=='t') PickedFocus=true; // snaps focus F to the selected vertex of P (easier to rotate and zoom while keeping it in center)
  if(key=='x' || key=='z' || key=='d') P.setPicked(); // picks the vertex of P that has closest projeciton to mouse
  if(key=='d') P.deletePicked();
  if(key=='i') P.insertClosestProjection(Of); // Inserts new vertex in P that is the closeset projection of O
  if(key=='W') {P.savePts("data/pts"); Q.savePts("data/pts2"); path.savePts("data/dance path");}  // save vertices to pts2
  if(key=='L') {P.loadPts("data/pts"); Q.loadPts("data/pts2"); path.loadPts("data/dance path");}   // loads saved model
  if(key=='w') P.savePts("data/pts");   // save vertices to pts
  if(key=='l') P.loadPts("data/pts"); 
  if(key=='a') animating=!animating; // toggle animation
  if(key==',') {if(showViewer) showViewer=false; else viewpoint=!viewpoint;}
  if(key=='#') exit();
  if(key=='b')solidBalls=!solidBalls;
  if(key=='=') {}
  if(key=='o') {
    hipRadius = 10;
    P.copyFrom(path);
    stageTwo=true;
    a = 11;
    b = 0;
    c = 1;
    A = P.G[a];
    B = P.G[b];
    C = P.G[c];
    d = P.L[c];
    left = P(B);
    right = P(A);
    memory = P(A);
    origin = P(right);
    target = P(left);
    front = V(origin, target).normalize();
    right = P(origin, 18, R(front));
    memory = P(origin, 18, R(front));
    left = P(target, -18, R(front));
    angleChange = angle(V(B,A),V(B,C)) / maxf;
    t = 0;
  }
  change=true;   // to save a frame for the movie when user pressed a key 
  }

void mouseWheel(MouseEvent event) 
  {
  dz -= event.getAmount(); 
  change=true;
  }

void mousePressed() 
  {
  if (!keyPressed) picking=true;
  if (!keyPressed) P.setPicked();
  change=true;
  }
  
void mouseMoved() 
  {
  if (keyPressed && key==' ') {rx-=PI*(mouseY-pmouseY)/height; ry+=PI*(mouseX-pmouseX)/width;};
  if (keyPressed && key=='s') dz+=(float)(mouseY-pmouseY); // approach view (same as wheel)
  change=true;
  }
  
void mouseDragged() 
  {
  if (!keyPressed) P.setPickedTo(Of); 
//  if (!keyPressed) {Of.add(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); }
  if (keyPressed && key==CODED && keyCode==SHIFT) {Of.add(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0)));};
  if (keyPressed && key=='x') P.movePicked(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='z') P.movePicked(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='X') P.moveAll(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='Z') P.moveAll(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='f')  // move focus point on plane
    {
    if(center) F.sub(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    else F.add(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    }
  if (keyPressed && key=='F')  // move focus point vertically
    {
    if(center) F.sub(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    else F.add(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    }
  change=true;
  }  

// **** Header, footer, help text on canvas
void displayHeader()  // Displays title and authors face on screen
    {
    scribeHeader(title,0); scribeHeaderRight(name); 
    fill(white); image(myFace, width-myFace.width/2,25,myFace.width/2,myFace.height/2); 
    }
void displayFooter()  // Displays help text at the bottom
    {
    scribeFooter(guide,1); 
    scribeFooter(menu,0); 
    }

String title ="3451 P3 2016: Dancer", name ="Alan Jiang & Janet Liang",
       menu="?:help, !:picture, ~:(start/stop)capture, space:rotate, s/wheel:closer, f/F:refocus, a:anim, #:quit",
       guide="Control Points x/z:select&edit, e:exchange, q/p:copy, l/L:load, w/W:write, C/K:show caplet/cone"; // user's guide