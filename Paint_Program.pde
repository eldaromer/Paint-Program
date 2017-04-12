//Modes  
//pixelart = 1
//erase = 2
//lines = 3
//brush = 4
//fill = 5
//box = 6
//circle = 7
//Circle values start
int s1;
int s2;
int s3;
int s4;
//Circle values end
//Box values start
int b1;
int c1;
int b2;
int c2;
//Box values end
//Line values start
int x1;
int y1;
int x2;
int y2;
//Line values end
//Transition values start
int linestop;
int circlestop;
int boxstop;
//Transition values end
//Brush size values start
int weight;
int w;
int l;
//Brush size values end
int mode;
//Constant value
int third = (1366/3)*2;
//Stores draw color
color c;
//Initialize images start
PImage circle;
PImage bos;
PImage filler;
PImage dot;
PImage line;
PImage brush;
PImage pallet;
PImage erase;
//Initialize images end
//Pixel art values
float x;
float y;
int cols = third;
int rows = 699;
//Initialize layer 1
color [] [] layer1 = new color [cols][rows];
//Initialize layer 2
color [] [] layer2 = new color [cols][rows];
//Initialize and declare grid toggle
int gridt = 0;
void setup()
{
  frameRate(75);
  size(1366, 768);
  background(255);
  //Set initial mode
  mode = 1;
  //Initialize transitions
  boxstop=0;
  linestop=0;
  circlestop=0;
  //Initialize Pictures
  circle=loadImage("Circle.png");
  filler=loadImage("Paintbucket.jpg");
  bos=loadImage("Box.png");
  brush=loadImage("Paintbrush.png");
  dot=loadImage("Dot.png");
  line=loadImage("Line.png");
  pallet=loadImage("Colors.png");
  erase=loadImage("Erase_Icon.png");
  //Sets beginning color to black
  color(0);
  //Sets pixel size
  w=10;
  l=10;
  //Sets initial brush size
  weight=10;
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      layer1[i][j] = get(i, j);
    }
  }
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      layer2[i][j] = get(i, j);
    }
  }
}
void draw()
{

  //Draws original display
  noStroke();
  fill(c);
  image(circle, 408, 700);
  image(bos, 340, 700);
  image(brush, 204, 700);
  image(pallet, 939, 0);
  image(erase, 0, 700);
  image(dot, 68, 700);
  image(line, 136, 700);
  if (mousePressed)
  {
    //Start of circle draw
    if (mode==7 && mouseX<third && mouseY<700 && circlestop==0)
    {
      s1=mouseX;
      s2=mouseY;
      circlestop=1;
    }
    //Start of box draw
    if (mode==6 && mouseX<third && mouseY<700 && boxstop==0)
    {
      b1=mouseX;
      c1=mouseY;
      boxstop=1;
    }
    //Fill function
    if (mode==5 && mouseX<third && mouseY<700)
    {
    }
    //Brush tool
    if (mode==4 && mouseX<third && mouseY<700)
    {
      ellipse(mouseX, mouseY, w, l);
    }
    //Start of line draw
    if (mode==3 && mouseX<third && mouseY<700 && linestop==0)
    {
      x1=mouseX;
      y1=mouseY;
      linestop=1;
    }
    //Eraser
    if (mode==2 && mouseX<third && mouseY<700)
    {
      fill(255);
      ellipse(mouseX, mouseY, w, l);
    }
    //Pixel art tool
    if (mode==1)
    {
      if (mouseX<third && mouseY<700)
      {
        x = mouseX/10;
        x= x-0.5;
        round(x);
        x= x*10;
        x = x+5;
        y = mouseY/10;
        y= y-0.5;
        round(y);
        y = y*10;
        y = y+5;
        rect(x, y, w, l);
      }
    }
    //Start of mode sets
    if (mouseX>408 && mouseX<476 && mouseY>700)
    {
      mode=7;
    }
    if (mouseX>340 && mouseX<408 && mouseY>700)
    {
      mode=6;
    }
    if (mouseX>272 && mouseX<340 && mouseY>700)
    {
      mode=5;
    }
    if (mouseX>204 && mouseX<272 && mouseY>700)
    {
      mode=4;
    }
    if (mouseX>136 && mouseX<204 && mouseY>700)
    {
      mode=3;
    }
    if (mouseX<68 && mouseY>700)
    {
      mode=2;
    }
    if (mouseX>68 && mouseX<136 && mouseY>700)
    {
      mode=1;
    }
    //End of mode sets
    //Sets color
    if (mouseX>third && mode!=2)
    {
      c = get(mouseX, mouseY);
    }
  } 
  if (keyPressed)
  {
    if (key=='S' || key=='s')
    {
      saveFrame("pic-###.png");
    }
    if (key==71) {
    }
    //Switches to layer 2
    if (key==50)
    {
      int time = millis();
      print("Start\n");
      print(time);
      print('\n');
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          if (get(i, j) != -1) {
            layer1[i][j] = get(i, j);
          }
        }
      }
      time = millis();
      print("Stored\n");
      print(time);
      print('\n');
      noStroke();
      fill(c);
      image(brush, 204, 700);
      image(pallet, third, 0);
      image(erase, 0, 700);
      image(dot, 68, 700);
      image(line, 136, 700);
      background(255);
      int timeBeg = 0;
      int timeEnd = 0;
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          stroke(layer2[i][j]);
          timeBeg = millis();
          point(i, j);
          timeEnd = millis();
        }
      }
      time = millis();
      print("Displayed\n");
      print((timeEnd - timeBeg)+'\n');
    }
    //Switches to layer 1
    if (key==49)
    {
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          if (get(i, j) != -1) {
            layer2[i][j] = get(i, j);
          }
        }
      }
      noStroke();
      fill(c);
      image(brush, 204, 700);
      image(pallet, third, 0);
      image(erase, 0, 700);
      image(dot, 68, 700);
      image(line, 136, 700);
      background(255);
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          stroke(layer1[i][j]);
          point(i, j);
        }
      }
    }
    if (key==51)
    {
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          stroke(layer1[i][j]);
          point(i, j);
        }
      }
      for (int i = 0; i < cols; i++)
      {
        for (int j = 0; j < rows; j++)
        {
          stroke(layer2[i][j]);
          point(i, j);
        }
      }
    }
    if (key==CODED)
    {
      //Decreases size
      if (keyCode==DOWN)
      {
        l--;
        w--;
        weight--;
      }
      //Increases size
      if (keyCode==UP)
      {
        l++;
        w++;
        weight++;
      }
      //Resets screen
      if (keyCode==LEFT)
      {
        noStroke();
        fill(c);
        image(brush, 204, 700);
        image(pallet, third, 0);
        image(erase, 0, 700);
        image(dot, 68, 700);
        image(line, 136, 700);
        background(255);
      }
    }
  }
}
void mouseReleased()
{
  //End of line draw
  if (mode==3 && mouseX<third && mouseY<700 && linestop==1)
  {
    stroke(c);
    strokeWeight(weight);
    x2=mouseX;
    y2=mouseY;
    line(x1, y1, x2, y2);
    linestop=0;
    noStroke();
  }
  //End of box draw
  if (mode==6 && mouseX<third && mouseY<700 && boxstop==1)
  {
    fill(c);
    noStroke();
    b2=mouseX;
    c2=mouseY;
    rectMode(CORNERS);
    rect(b1, c1, b2, c2);
    boxstop=0;
    rectMode(CORNER);
  }
  //End of circle draw
  if (mode==7 && mouseX<third && mouseY<700 && circlestop==1)
  {
    fill(c);
    noStroke();
    s3=mouseX;
    s4=mouseY;
    ellipseMode(CORNERS);
    ellipse(s1, s2, s3, s4);
    circlestop=0;
    ellipseMode(CENTER);
  }
}

