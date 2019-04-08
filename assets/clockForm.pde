/* Declare some constants */
float easing=0.03;
int diameter = 20;
float handDotGap = 20;
float secondLength = 320;
float minLength = 240;
float hourLength = 160;

float second, minute, hour; 
float deltaX, deltaY, targetX, targetY;

class ball
{
  int id;
  float x;
  float y;
  float dia;

  ball(int posX, int posY, int diameter, int iden)
  {
    dia = diameter;
    x = posX;
    y = posY;
    id = iden;
  }

  void noJitter()
  {
    ellipse(x, y, dia, dia);
  }

  void jitter(int intensity)
  {
    ellipse(x+random(-intensity, intensity), y+random(-intensity, intensity), dia, dia);
  }

  void transform()
  {
    float[][] targetHour= new float[int(hourLength/handDotGap)][2];
    float[][] targetMin= new float[int(minLength/handDotGap)][2];
    float[][] targetSec= new float[int(secondLength/handDotGap)][2];
    float[] deltaX= new float[36];
    float[] deltaY= new float[36];
    targetHour = generatePos(width/2, height/2, hour, hourLength, handDotGap);
    targetMin = generatePos(width/2, height/2, minute, minLength, handDotGap);
    targetSec = generatePos(width/2, height/2, second, secondLength, handDotGap);

    if (id<8)
    {
      deltaX[id] = targetHour[id][0] - x;
      deltaY[id] = targetHour[id][1] - y;
      x += deltaX[id]*easing;
      y += deltaY[id]*easing;
    }

    if (id>=8 && id<20)
    {
      //id = id-8;
      deltaX[id] = targetMin[id-8][0] - x;
      deltaY[id] = targetMin[id-8][1] - y;
      x += deltaX[id]*easing;
      y += deltaY[id]*easing;
    }
    if (id>=20 && id<36)
    {
      //id = id-20;
      deltaX[id] = targetSec[id-20][0] - x;
      deltaY[id] = targetSec[id-20][1] - y;
      x += deltaX[id]*easing;
      y += deltaY[id]*easing;
    }
    fill(0,128,128);
    ellipse(x, y, diameter, diameter);
  }
}

ball[] Ball = new ball[36];

void setup()
{
    fill(0,128,128);

  size(500,500); //1080 x 1920
  //background(60, 30, 64); //purple
  smooth();
  noStroke();
  println(int(secondLength/handDotGap));

  //int index;
  //for (int i=0;i<6;i++)
  //{
  //  for (int j=0;j<6;j++)
  //  {
  //    index = i+6*j;
  //    Ball[index] = new ball(100+100*i,100+100*j,diameter,index);
  //  }
  //}
  
  for (int j=0; j<36; j++)
  {

    Ball[j] = new ball(int(random(0, 1080)), int(random(0, 1920)), diameter, j);
  }
}
int flag=0;
float startTime;

void draw()
{
  second = second()*2*PI/60 - PI/2;
  minute = minute()*2*PI/60 - PI/2 + second/60;
  hour = hour()*2*PI/12 - PI/2 + minute/60;

  background(64, 224, 208); //0  199  140

  if (mousePressed)
  {
    flag = 1;
    startTime = millis();
  }

  if (flag == 0)
  {
    for (int i=0; i<36; i++)
    {
      Ball[i].jitter(2);
    }
  }

  if (flag == 1)
  {
    for (int i=0; i<36; i++)
    {
      Ball[i].jitter(0);
      Ball[i].transform();
    }
  }

  if (millis() - startTime >= 10000)
  {
    flag = 0;
  }
}


float[][] generatePos(float x, float y, float theta, float len, float gap)
{
  int num = int(len/gap);
  float[][] positions = new float[num][2];
  for (int i=0; i < num; i++)
  {
    positions[i][0] = x+i*gap*cos(theta);
    positions[i][1] = y+i*gap*sin(theta);
  }
  return positions;
}


/*void polarLine(float x, float y, float r, float theta)
 {
 line(x, y, x+r*cos(theta), y+r*sin(theta));
 }
 
 void makeDotLine(float x, float y, float theta, float dia, float len, float gap)
 {
 float num = len/gap;
 for (int i=0; i < num; i++)
 {
 ellipse(x+i*gap*cos(theta), y+i*gap*sin(theta), dia, dia);
 }
 }
 
 void makeDots(int num)
 {
 for (int i=0; i<sqrt(num); i++)
 for (int j=0; j<sqrt(num); j++)
 {
 {
 
 
 ellipse(diameter/2+100*i, diameter/2+100*j, diameter, diameter);
 }
 }
 }
 */