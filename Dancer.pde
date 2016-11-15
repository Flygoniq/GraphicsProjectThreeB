// Student's should use this to render their model
float footRadius = 3.75, kneeRadius = 6, hipRadius = 10, ankleRadius = 5; // radius of foot, knee, hip
float hipSpread = hipRadius; // half-displacement between hips
float bodyHeight = 150; // height of body center B
float pelvisHeight = 10, pelvisForward = hipRadius/2, pelvisRadius = hipRadius*1.3; // vertical distance form BodyCenter to Pelvis
float hipToKnee = 84, kneeToAnkle = 69, ankleToBall = 11.25, ballToToe = 12;
float hipAngle = PI / 30;

float midRadius = 11, torsoRadius = 15, neckRadius = 4, headRadius = 14, shoulderRadius = 5, elbowRadius = 3.75, wristRadius = 2.5, handRadius = 4;
float midHeight = 20, torsoHeight = 40, upperArmLength = 60, lowerArmLength = 50, neckLength = 10;

void showDancer(pt LeftFoot, float transfer, pt RightFoot, vec Forward)
  {
<<<<<<< HEAD

  vec Dummy = V(0, 0, 0);
=======
  float footRadius=3, kneeRadius = 6,  hipRadius=15 ; // radius of foot, knee, hip
  float hipSpread = hipRadius; // half-displacement between hips
  float bodyHeight = 100; // height of body center B
  float ankleBackward=10, ankleInward=4, ankleUp=6, ankleRadius=4; // ankle position with respect to footFront and size
  float pelvisHeight=10, pelvisForward=hipRadius/2, pelvisRadius=hipRadius*1.3; // vertical distance form BodyCenter to Pelvis 
  float LeftKneeForward = 20; // arbitrary knee offset for mid (B,H)
>>>>>>> origin/master
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
  fill(blue); arrow(BodyCenter,V(100,Forward),5); // forward arrow

  // HIPS
  pt RightHip =  P(BodyCenter,hipSpread,Right);
  fill(red);  sphere(RightHip,hipRadius);
  pt LeftHip =  P(BodyCenter,-hipSpread,Right);
  fill(green);  sphere(LeftHip,hipRadius); 
  
  // PELVIS
  pt Pelvis = P(BodyCenter,pelvisHeight,Up, pelvisForward,Forward); 
  fill(blue); sphere(Pelvis,pelvisRadius);
  capletSection(LeftHip,hipRadius,Pelvis,pelvisRadius);  
  capletSection(RightHip,hipRadius,Pelvis,pelvisRadius); 
  
  //UPPER BODY
  pt midSection = P(BodyCenter, midHeight, Up, pelvisForward, Forward);
  fill(blue);
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
  
  sphere(rightWrist, handRadius);
  sphere(leftWrist, handRadius);
  
  pt bottomNeck = P(upperTorso, torsoRadius - 5, Up);
  sphere(bottomNeck, neckRadius);
  
  pt upperNeck = P(bottomNeck, neckLength, Up);
  sphere(upperNeck, neckRadius);
  capletSection(bottomNeck, neckRadius, upperNeck, neckRadius);
  
  pt head = P(upperNeck, headRadius - 5, Up);
  sphere(head, headRadius);
  
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
  sphere(RightHip, hipRadius);
  sphere(RightKnee, kneeRadius);
  capletSection(RightHip, hipRadius, RightKnee, kneeRadius);
  capletSection(RightKnee, kneeRadius, RightAnkle, ankleRadius);
  capletSection(RightAnkle, ankleRadius, RightFoot, footRadius);
  
  fill(green);
  sphere(LeftHip, hipRadius);
  sphere(LeftKnee, kneeRadius);
  capletSection(LeftHip, hipRadius, LeftKnee, kneeRadius);
  capletSection(LeftKnee, kneeRadius, LeftAnkle, ankleRadius);
  capletSection(LeftAnkle, ankleRadius, LeftFoot, footRadius);
  
  fill(blue);
  sphere(RightAnkle,ankleRadius);
  sphere(RightFoot,footRadius);
  pt RightToe =   P(RightFoot,5,Forward);
  capletSection(RightFoot,footRadius,RightToe,1);
 
  sphere(LeftAnkle,ankleRadius);
  sphere(LeftFoot,footRadius);
  pt LeftToe =   P(LeftFoot,5,Forward);
  capletSection(LeftFoot,footRadius,LeftToe,1);
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