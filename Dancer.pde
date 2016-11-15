// Student's should use this to render their model
float footRadius = 3.75, kneeRadius = 6, hipRadius = 10, ankleRadius = 5; // radius of foot, knee, hip
float hipSpread = hipRadius; // half-displacement between hips
float bodyHeight = 150; // height of body center B
float pelvisHeight = 10, pelvisForward = hipRadius/2, pelvisRadius = hipRadius*1.3; // vertical distance form BodyCenter to Pelvis
float hipToKnee = 84, kneeToAnkle = 69, ankleToBall = 11.25, ballToToe = 12;
float hipAngle = PI / 30;
float midRadius = 11, torsoRadius = 15, neckRadius = 4, headRadius = 14, shoulderRadius = 5, elbowRadius = 3.75, wristRadius = 2.5, handRadius = 4;
float midHeight = 20, torsoHeight = 40, upperArmLength = 60, lowerArmLength = 50, neckLength = 10;

float distance = 90;
float footRadius2 = 3.75, kneeRadius2 = 6, ankleRadius2 = 5;
float dressLength = 120;
float bottomDressRadius = 45, topDressRadius = 15;
float hairRadius = 14, hairLength = 34;
float lowerArmLength2 = 25;
float shoulderRadius2 = 7, elbowRadius2 = 5, wristRadius2 = 2.5;

void showDancer(pt LeftFoot, float transfer, pt RightFoot, vec Forward, boolean stageTwo)
  {

  vec Dummy = V(0, 0, 0);
  vec Up = V(0,0,1); // up vector
  vec Right = N(Up,Forward); // side vector pointing towards the right
  
  vec RDownBack = A(A(A(Dummy, -0.25, Forward), 0.5, Right), -1, Up);
  vec LDownBack = A(A(A(Dummy, -0.25, Forward), -0.5, Right), -1, Up);
  vec RUpForward = A(A(A(Dummy, 1.25, Forward), -0.4, Right), 0.5, Up);
  vec LUpForward = A(A(A(Dummy, 1.25, Forward), 0.4, Right), 0.5, Up);
  
  // BODY
  pt BodyProjection = L(LeftFoot,1./3+transfer/3,RightFoot); // floor projection of B
  pt BodyCenter = P(BodyProjection,bodyHeight,Up); // Body center
  fill(blue); showShadow(BodyCenter,5); // sphere(BodyCenter,hipRadius);
  if (!stageTwo) { fill(blue); arrow(BodyCenter,V(100,Forward),5); } // forward arrow

  // HIPS
  pt RightHip =  P(BodyCenter,hipSpread,Right);
  fill(red);
  if(stageTwo) fill(black);
  sphere(RightHip,hipRadius);
  pt LeftHip =  P(BodyCenter,-hipSpread,Right);
  fill(green);
  if(stageTwo) fill(black);
  sphere(LeftHip,hipRadius); 
  
  // PELVIS
  pt Pelvis = P(BodyCenter,pelvisHeight,Up, pelvisForward,Forward); 
  fill(blue); 
  if(stageTwo) fill(black);
  sphere(Pelvis,pelvisRadius);
  capletSection(LeftHip,hipRadius,Pelvis,pelvisRadius);  
  capletSection(RightHip,hipRadius,Pelvis,pelvisRadius); 
  
  // EVERYTHING ELSE
  vec RHB = V(RightHip, RightFoot);
  vec LHB = V(LeftHip, LeftFoot);

  pt RightKnee =  P(RightHip, hipToKnee / n(RHB), R(RHB, hipAngle, U(RHB), Forward));
  pt LeftKnee = P(LeftHip, hipToKnee / n(LHB), R(LHB, hipAngle, U(LHB), Forward));
  
  vec RKB = V(RightKnee, RightFoot);
  vec LKB = V(LeftKnee, LeftFoot);
  
  float RAA = acos((sq(kneeToAnkle) + sq(n(RKB)) - sq(ankleToBall)) / (2 * kneeToAnkle * n(RKB)));
  float LAA = acos((sq(kneeToAnkle) + sq(n(LKB)) - sq(ankleToBall)) / (2 * kneeToAnkle * n(LKB)));
  
  pt RightAnkle = P(RightKnee, kneeToAnkle / n(RKB), R(RKB, -RAA, U(RKB), Forward));
  pt LeftAnkle = P(LeftKnee, kneeToAnkle / n(LKB), R(LKB, -LAA, U(LKB), Forward));

  fill(red);
  if(stageTwo) fill(black);
  sphere(RightHip, hipRadius);
  sphere(RightKnee, kneeRadius);
  capletSection(RightHip, hipRadius, RightKnee, kneeRadius);
  capletSection(RightKnee, kneeRadius, RightAnkle, ankleRadius);
  capletSection(RightAnkle, ankleRadius, RightFoot, footRadius);
  
  fill(green);
  if(stageTwo) fill(black);
  sphere(LeftHip, hipRadius);
  sphere(LeftKnee, kneeRadius);
  capletSection(LeftHip, hipRadius, LeftKnee, kneeRadius);
  capletSection(LeftKnee, kneeRadius, LeftAnkle, ankleRadius);
  capletSection(LeftAnkle, ankleRadius, LeftFoot, footRadius);
  
  fill(blue);
  if(stageTwo) fill(black);
  sphere(RightAnkle,ankleRadius);
  sphere(RightFoot,footRadius);
  pt RightToe =   P(RightFoot,5,Forward);
  capletSection(RightFoot,footRadius,RightToe,1);
 
  sphere(LeftAnkle,ankleRadius);
  sphere(LeftFoot,footRadius);
  pt LeftToe =   P(LeftFoot,5,Forward);
  capletSection(LeftFoot,footRadius,LeftToe,1);
  
  if(stageTwo) {
    //UPPER BODY
    pt midSection = P(BodyCenter, midHeight, Up, pelvisForward, Forward);
    fill(black);
    sphere(midSection, midRadius);
    capletSection(Pelvis, pelvisRadius, midSection, midRadius);
    
    pt upperTorso = P(midSection, torsoHeight, Up);
    sphere(upperTorso, torsoRadius);
    capletSection(midSection, midRadius, upperTorso, torsoRadius);
    
    pt rightShoulder = P(upperTorso, torsoRadius, Right);
    pt leftShoulder = P(upperTorso, -torsoRadius, Right);
    
    sphere(rightShoulder, shoulderRadius);
    capletSection(rightShoulder, shoulderRadius, upperTorso, torsoRadius);
    sphere(leftShoulder, shoulderRadius);
    capletSection(leftShoulder, shoulderRadius, upperTorso, torsoRadius);
    
    pt rightElbow = P(rightShoulder, upperArmLength, RDownBack);
    pt leftElbow = P(leftShoulder, upperArmLength, LDownBack);
    
    sphere(rightElbow, elbowRadius);
    capletSection(rightElbow, elbowRadius, rightShoulder, shoulderRadius);
    sphere(leftElbow, elbowRadius);
    capletSection(leftElbow, elbowRadius, leftShoulder, shoulderRadius);
    
    pt rightWrist = P(rightElbow, lowerArmLength, RUpForward);
    pt leftWrist = P(leftElbow, lowerArmLength, LUpForward);
    
    sphere(rightWrist, wristRadius);
    capletSection(rightWrist, wristRadius, rightElbow, elbowRadius);
    sphere(leftWrist, wristRadius);
    capletSection(leftWrist, wristRadius, leftElbow, elbowRadius);
    
    fill(white);
    sphere(rightWrist, handRadius);
    sphere(leftWrist, handRadius);
    
    pt bottomNeck = P(upperTorso, torsoRadius - 5, Up);
    sphere(bottomNeck, neckRadius);
    
    pt upperNeck = P(bottomNeck, neckLength, Up);
    sphere(upperNeck, neckRadius);
    capletSection(bottomNeck, neckRadius, upperNeck, neckRadius);
    
    pt head = P(upperNeck, headRadius - 5, Up);
    sphere(head, headRadius);
    
    //Partner
    vec Forward2 = A(Dummy, -1, Forward);
    vec Right2 = N(Up, Forward2);
    vec UpForward = A(A(Dummy, 1, Forward), 1, Up);
    
    vec RDownForward = A(A(A(Dummy, 0.25, Forward), 0.5, Right), -1, Up);
    vec LDownForward = A(A(A(Dummy, 0.25, Forward), -0.5, Right), -1, Up);
    
    // BODY
    pt RightFoot2 = P(LeftFoot, distance, Forward);
    pt LeftFoot2 = P(RightFoot, distance, Forward);
    pt BodyProjection2 = L(RightFoot2, 1./3+transfer/3, LeftFoot2); // floor projection of B
    pt BodyCenter2 = P(BodyProjection2, bodyHeight, Up); // Body center
    fill(blue); showShadow(BodyCenter2, 5); // sphere(BodyCenter,hipRadius);
    
    // HIPS
    pt RightHip2 =  P(BodyCenter2, hipSpread, Right2);
    fill(cyan);
    sphere(RightHip2, hipRadius);
    pt LeftHip2 =  P(BodyCenter2, -hipSpread, Right2);
    sphere(LeftHip2, hipRadius); 
    
    // PELVIS
    pt Pelvis2 = P(BodyCenter2, pelvisHeight, Up, pelvisForward, Forward2); 
    sphere(Pelvis2, pelvisRadius);
    capletSection(LeftHip2, hipRadius, Pelvis2, pelvisRadius);  
    capletSection(RightHip2, hipRadius, Pelvis2, pelvisRadius);
    
    //TORSO
    pt bottomDress = P(Pelvis2, -100, Up);
    pt topDress = P(bottomDress, dressLength, Up);
    fill(orange);
    sphere(topDress, topDressRadius);
    capletSection(bottomDress, bottomDressRadius, topDress, topDressRadius);
    
    pt bottomNeck2 = P(topDress, topDressRadius - 1, Up);
    pt upperNeck2 = P(bottomNeck2, neckLength, Up);
    fill(cyan);
    capletSection(bottomNeck2, neckRadius, upperNeck2, neckRadius);
    
    pt head2 = P(upperNeck2, headRadius - 5, Up);
    sphere(head2, headRadius);
    
    pt rightShoulder2 = P(topDress, topDressRadius, Right);
    pt leftShoulder2 = P(topDress, -topDressRadius, Right);
    sphere(rightShoulder2, shoulderRadius2);
    sphere(leftShoulder2, shoulderRadius2);
    
    pt rightWrist2 = P(rightWrist, 3, Forward);
    pt leftWrist2 = P(leftWrist, 3, Forward);
    sphere(rightWrist2, handRadius);
    sphere(leftWrist2, handRadius);
    
    pt rightElbow2 = P(rightWrist2, lowerArmLength2, RDownForward);
    pt leftElbow2 = P(leftWrist2, lowerArmLength2, LDownForward);
    sphere(rightElbow2, elbowRadius2);
    sphere(leftElbow2, elbowRadius2);
    capletSection(rightWrist2, wristRadius2, rightElbow2, elbowRadius2);
    capletSection(leftWrist2, wristRadius2, leftElbow2, elbowRadius2);
    capletSection(rightElbow2, elbowRadius2, rightShoulder2, shoulderRadius2);
    capletSection(leftElbow2, elbowRadius2, leftShoulder2, shoulderRadius2);
    
    
    fill(red);
    pt hairTop = P(head2, 1, UpForward);
    sphere(hairTop, hairRadius);
    
    // EVERYTHING ELSE
    fill(cyan);
    vec RHB2 = V(RightHip2, RightFoot2);
    vec LHB2 = V(LeftHip2, LeftFoot2);
  
    
    pt RightKnee2 =  P(RightHip2, hipToKnee / n(RHB2), R(RHB2, hipAngle, U(RHB2), Forward2));
    pt LeftKnee2 = P(LeftHip2, hipToKnee / n(LHB2), R(LHB2, hipAngle, U(LHB2), Forward2));
    
    vec RKB2 = V(RightKnee2, RightFoot2);
    vec LKB2 = V(LeftKnee2, LeftFoot2);
    
    float RAA2 = acos((sq(kneeToAnkle) + sq(n(RKB2)) - sq(ankleToBall)) / (2 * kneeToAnkle * n(RKB2)));
    float LAA2 = acos((sq(kneeToAnkle) + sq(n(LKB2)) - sq(ankleToBall)) / (2 * kneeToAnkle * n(LKB2)));
    
    pt RightAnkle2 = P(RightKnee2, kneeToAnkle / n(RKB2), R(RKB2, -RAA2, U(RKB2), Forward2));
    pt LeftAnkle2 = P(LeftKnee2, kneeToAnkle / n(LKB2), R(LKB2, -LAA2, U(LKB2), Forward2));
    
    sphere(RightHip2, hipRadius);
    sphere(RightKnee2, kneeRadius);
    capletSection(RightHip2, hipRadius, RightKnee2, kneeRadius);
    capletSection(RightKnee2, kneeRadius, RightAnkle2, ankleRadius);
    capletSection(RightAnkle2, ankleRadius, RightFoot2, footRadius);
    
    sphere(LeftHip2, hipRadius);
    sphere(LeftKnee2, kneeRadius);
    capletSection(LeftHip2, hipRadius, LeftKnee2, kneeRadius);
    capletSection(LeftKnee2, kneeRadius, LeftAnkle2, ankleRadius);
    capletSection(LeftAnkle2, ankleRadius, LeftFoot2, footRadius);
  
    sphere(RightAnkle2, ankleRadius);
    sphere(RightFoot2, footRadius);
    pt RightToe2 = P(RightFoot2, 5, Forward2);
    capletSection(RightFoot2, footRadius, RightToe2, 1);
   
    sphere(LeftAnkle2, ankleRadius);
    sphere(LeftFoot2, footRadius);
    pt LeftToe2 = P(LeftFoot2, 5, Forward2);
    capletSection(LeftFoot2, footRadius, LeftToe2, 1);
  }
}
  
void capletSection(pt A, float a, pt B, float b) { // cone section surface that is tangent to Sphere(A,a) and to Sphere(B,b)
  float d = d(A, B); //d is the distance between A and B
  float x = (sq(a) - (b * a)) / d;
  float y = sqrt(sq(a) - sq(x));
  pt H = P(A, x / d, V(A, B));
  float ox = (sq(b) - (b * a)) / d;
  float oy = sqrt(sq(b) - sq(ox));
  pt OH = P(B, ox / d, V(B, A));
  coneSection(H,OH,y,oy);
}