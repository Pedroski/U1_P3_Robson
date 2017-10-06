PImage Ship;
PImage Alien;
int score = 1;
int sn = 100;
int an = 100;
int shn = 10000;
int y = 900;
int shipsize = 100;
int starsize = 4;
int enemysize = 50;
int laserlength = 900;
int laserwidth = 1;
int shotlength = 50;
int shotwidth = 5;
int[] StarXs = new int[sn];
float[] StarYs = new float[sn];
int[] EnemyXs = new int[an];
float[] EnemyYs = new float[an];
boolean[] enemyAlive = new boolean[an];
float[] ShotXs = new float[shn];
float[] ShotYs = new float[shn];
boolean[] wasShot = new boolean[shn];

void setup()
{
  fullScreen(P2D);
  Ship = loadImage("ship.png");
  Alien = loadImage("alien.png");
  imageMode(CENTER);
  for (int i=0; i < sn; i++)
  {
    StarXs[i] = (int) random(0, width);
    StarYs[i] = (int) random(0, height);
  }
  for (int i=0; i < score; i++)
  {
    EnemyXs[i] = (int) random(0, width);
    EnemyYs[i] = (int) random(-100, -50);
    enemyAlive[i] = false;
  }
  enemyAlive[0] = true;
  for (int i=0; i < shn; i++)
  {
    ShotXs[i] = mouseX;
    ShotYs[i] = y;
    wasShot[i]= false;
  }
}

void draw()
{
  background(0);
  text(score, width - 50, height - 50);
  drawStars();
  drawShots();
  drawPlayer();
  drawAliens();
  drawCollisions();
}

void mousePressed()
{
  for (int i=0; i < shn; i++)
  {
    if ( wasShot[i] == false )
    {
      ShotXs[i] = mouseX;
      ShotYs[i] = y;
      wasShot[i] = true;
      break;
    }
  }
}

void drawShots()
{
  for (int i=0; i < shn; i++)
  {
    if ( wasShot[i] == true )
    {
      fill(254, 255, 5);
      rect(ShotXs[i], ShotYs[i], shotwidth, shotlength);
      ShotYs[i] = ShotYs[i] - 20;
    }
  }
}

void drawPlayer()
{
  image(Ship, mouseX, y, shipsize, shipsize);
  fill(255, 0, 0);
  rect(mouseX, y, laserwidth, laserlength);
}

void drawStars()
{
  for (int i=0; i < sn; i++)
  {
    fill(250, 250, 250);
    ellipse(StarXs[i], StarYs[i], starsize, starsize);
    StarYs[i] = StarYs[i] + 10;
    if ( StarYs[i] > height )
    {
      StarXs[i] = (int) random(0, width);
      StarYs[i] = random(-5, 0);
    }
  }
}

void drawAliens()
{
  for (int i=0; i < score; i++)
  {
    if ( enemyAlive[i] == true )
    {
      fill(31, 124, 38);
      image(Alien, EnemyXs[i], EnemyYs[i], enemysize, enemysize);
      EnemyYs[i] = EnemyYs[i] + 2;
    }
  }
}

void drawCollisions()
{
  for (int i=0; i < score; i++)
  {
    for (int j=0; j < shn; j++)
    {
      if ( enemyAlive[i] == true )
      {
        if ( dist(ShotXs[j], ShotYs[j], EnemyXs[i], EnemyYs[i]) < 25+25 )
        {

          score++;
          EnemyXs[i] = (int) random(0, width);
          EnemyYs[i] = (int) random(-100, -50);
          enemyAlive[i] = false;
          enemyAlive[i + 1] = true;
          wasShot[j] = false;
          for (int k=0; k < score; k++)
          {
            if ( enemyAlive[i] == false )
            {
              enemyAlive[i] = true;
              break;
            }
          }
        }
        if ( EnemyYs[i] > height + 50 )
        {
          EnemyXs[i] = (int) random(0, width);
          EnemyYs[i] = (int) random(-100, -50);
        }
      }
    }
  }
}