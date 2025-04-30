Button start;
Button pause;
Button reset;
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

int startCount;

int passingSecond;
int passingSeconds;

int passingMilli;
int passingMillis;



void setup(){
  size(432, 768);
  start = new Button(width/2, height/2-50, 100, 30, "Start");
  pause = new Button(width/2, height/2-250, 100, 30, "Pause");
  reset = new Button(width/2, height/2-150, 100, 30, "Reset");
  setTime = new Button(width/2, height/2 + 150, 100, 30, "Set Time");
  bTimeSet = new Button(width/2, height/2 + 200, 100, 30, "Done");
  
  float os = (width-timeSettingZoneSize)/2;
  
    c1 = new Column(24, os +sh, xp);
  c2 = new Column(60,os +xp+ sh, xp);
  c3 = new Column(60, os +xp*2+sh, xp);
  
  
  timer = new Timer(60);
  
}

void draw(){
  
  frameRate(60);
  
  background(51);
  
  start.Display();
  if(start.endClick){
    timer.start();
  }
  pause.Display();
  if(pause.endClick){
    timer.pause();
  }
  reset.Display();
  if(reset.endClick){
    timer.setTime(60);
  }
  
  setTime.Display();
  if(setTime.endClick){
    timeSetting = true;
  }
  
  
  text(timer.getTimeSeconds(), width/2, height/2);
  
  
  if(timeSetting) TimeSetting();
  
}

int timeToSeconds(int seconds, int minutes, int hours){
  return seconds + minutes*60 + hours * 3600;
}

int[] secondsToTime(int seconds){
  int hrs = floor(seconds/3600);
  int min = floor((seconds-hrs*3600)/60);
  int sec = (seconds-hrs*3600-min*60);
  return new int[]{hrs, min, sec};
}

void setTimeScreen(){
  
}

void mouseDragged(){
  if(timeSetting){
    if (mouseY > 0 && mouseY < height) {
    c1.CheckMouse();
    c2.CheckMouse();
    c3.CheckMouse();
  }
  }
}
