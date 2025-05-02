Button setTime;
Button bTimeSet;


Column c1;
Column c2;
Column c3;

float timeSettingZoneSize = 300;
float sh = timeSettingZoneSize/6;
float xp = timeSettingZoneSize/3;
float tSize = round((xp*.9)/2);

Timer timer;
float standardSize = 300;
int count;

int startCount;

int passingSecond;
int passingSeconds;

int passingMilli;
int passingMillis;



void setup() {
  size(432, 768);
  setTime = new Button(new PVector(width/2, height/2 + 150), new PVector(100, 30), "Set Time");
  bTimeSet = new Button(new PVector(width/2, height/2 + 200), new PVector(100, 30), "Done");

  float os = (width-timeSettingZoneSize)/2;

  c1 = new Column(24, os +sh, xp);
  c2 = new Column(60, os +xp+ sh, xp);
  c3 = new Column(60, os +xp*2+sh, xp);

  float timerXpos = (width-standardSize)/2;
  timer = new Timer(60, timerXpos, 50, standardSize);
}

void draw() {

  frameRate(60);

  background(51);
  
  timer.Display(); //<>//
  timer.Update();

  setTime.Display();
  if (setTime.endClick) {
    timeSetting = true;
  }


  //text(timer.getTimeSeconds(), width/2, height/2);


  if (timeSetting){
    timer.setTime(timeToSeconds(TimeSetting()[2], TimeSetting()[1], TimeSetting()[0]));
  }
  
}

int timeToSeconds(int seconds, int minutes, int hours) {
  return seconds + minutes*60 + hours * 3600;
}

int[] secondsToTime(int seconds) {
  int hrs = floor(seconds/3600);
  int min = floor((seconds-hrs*3600)/60);
  int sec = (seconds-hrs*3600-min*60);
  return new int[]{hrs, min, sec};
}


void mouseDragged() {
  if (timeSetting) {
    if (mouseY > 0 && mouseY < height) {
      c1.CheckMouse();
      c2.CheckMouse();
      c3.CheckMouse();
    }
  }
}
