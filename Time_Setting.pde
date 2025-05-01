boolean timeSetting;
float ts = timeSettingZoneSize;


int[] TimeSetting(){
  
  float os = (height-ts)/2;
  push();
  
  translate(0,0);
  fill(74);
  rectMode(CENTER);
  rect(width/2, height/2, ts, ts);
  
  push();
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(3);
  line(-xp/2, -ts/2, -xp/2, ts/2);
  line(xp/2, -ts/2, xp/2, ts/2);
  pop();

  textAlign(CENTER);
  c1.Update();
  c2.Update();
  c3.Update();
  pop();
  
  push();
  noStroke();
  fill(51);
  rectMode(CORNERS);
  rect(0,0, width, os);
  rect(0,os+ts+1, width, height);
  pop();
  
  bTimeSet.Display();
  if(bTimeSet.endClick){
    timeSetting = false;
  }
  
  println(c1.number, c2.number, c3.number);
  return new int[]{c1.number, c2.number, c3.number};
}
