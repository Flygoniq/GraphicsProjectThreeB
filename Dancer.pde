// Student's should use this to render their model
float footRadius = 3.75, kneeRadius = 7.5, hipRadius = 12, ankleRadius = 5; // radius of foot, knee, hip
float hipSpread = hipRadius; // half-displacement between hips
float bodyHeight = 100; // height of body center B
float pelvisHeight = 10, pelvisForward = hipRadius/2, pelvisRadius = hipRadius*1.3; // vertical distance form BodyCenter to Pelvis
float hipToKnee = 56, kneeToAnkle = 46, ankleToBall = 13.6, ballToToe = 8;
float hipAngle = PI / 30;

float torsoRadius = 15, headRadius = 9, shoulderRadius = 7.5, elbowRadius = 3.75, wristRadius = 2.5, handRadius = 

void showDancer(pt LeftFoot, float transfer, pt RightFoot, vec Forward)
  {

  vec Up = V(0,0,1); // up vector
  
  vec Right = N(Up,Forward); // side vector pointing towards the right
  
  // BODY
  pt BodyProjection = L(LeftFoot,1./3+transfer/3,RightFoot); // floor projection of B
  pt BodyCenter = P(BodyProjection,bodyHeight,Up); // Body center
  fill(blue); showShadow(BodyCenter,5); // sphere(BodyCenter,hipRadius);
  //fill(blue); arrow(BodyCenter,V(100,Forward),5); // forward arrow

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