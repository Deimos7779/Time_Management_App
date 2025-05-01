/**
 * The Timer class represents a simple countdown timer
 * to help with timed events. Timers can be started and then
 * checked as to whether they have finished or not.
 */
class Timer {
  Button start;
  Button pause;
  Button reset;
  Button delete;
  Button offset;
  
  PVector position;
  float size;
  int seconds;
  float buttonSize;

  float elapsedTime;
  float currTimeMillis;
  float totalTimeMillis;
  float pauseTotalMillis;
  boolean pauseTimeAssigned;
  boolean isStarted;
  boolean isPaused;
  float pauseBufferMillis;

  //Default Constructor: Assumes the Timer will run for 1000 milliseconds
  Timer()
  {
    this(1);
  }

  Timer(int timeInSeconds)
  {
    setTime(timeInSeconds);
  }

  //Constructor: accepts the running time of the Timer in seconds.
  Timer(int timeInSeconds, float x, float y, float s)
  {
    this.position = new PVector(x, y);
    this.size = s;
    this.buttonSize = size/7;
    this.start = new Button(size/2-buttonSize/2, size -60, buttonSize, buttonSize, "StartIcon.png");
    this.pause = new Button(size/2-buttonSize*1.5 -10, size -60, buttonSize, buttonSize, "PauseIcon.png");
    this.reset = new Button(size/2 + buttonSize/2 +10, size -60, buttonSize, buttonSize, "ResetIcon.png");
    this.delete = new Button(10, 10, buttonSize, buttonSize, "DeleteIcon.png");
    this.offset = new Button(size-10-buttonSize, 10, buttonSize, buttonSize, "OffsetIcon.png");
    setTime(timeInSeconds);
    isStarted = false;
    isPaused = true;
    
    start.SetPanel(position.x, position.y);
   pause.SetPanel(position.x, position.y);
   reset.SetPanel(position.x, position.y);
   delete.SetPanel(position.x, position.y);
   offset.SetPanel(position.x, position.y);
  }

  void Display() { //<>//
    rect(position.x, position.y, size, size);

    //Display all the necessary buttons
    push();
    translate(position.x, position.y);
    start.Display();
    pause.Display();
    reset.Display();
    delete.Display();
    offset.Display();
    pop();

    //display points to separate the three clock numbers.
    push();
    translate(position.x, position.y);
    stroke(255);
    strokeWeight(5);
    point(size/3, size/2 - 20);
    point(size/3, size/2 + 20);
    point(size/3*2, size/2 - 20);
    point(size/3*2, size/2 + 20);
    pop();

    //display the numbers of the clock
    int sec, min, hrs;
    sec = secondsToTime(seconds)[0];
    min = secondsToTime(seconds)[1];
    hrs = secondsToTime(seconds)[2];
    push();
    translate(position.x, position.y);
    fill(255);
    float textSize = size/3*.75;
    textSize(textSize);
    text(nf(sec, 2), size/6, size/2);
    text(nf(min, 2), size/6+size/3, size/2);
    text(nf(hrs, 2), size/6+(size/3)*2, size/2);
    pop();
  }

  void Update() {
    seconds = floor(timer.getTimeSeconds());
    
    if (start.endClick) {
      timer.start();
    }
    if (pause.endClick) {
      timer.pause();
    }
    if (reset.endClick) {
      timer.setTime(60);
    }
  }


  //Begins the Timer countdown
  void start()
  {
    if (!isStarted) {
      currTimeMillis = millis();
      isStarted = true;
      isPaused = false;
    } else if (isPaused) {
      currTimeMillis += pauseBufferMillis;
      isPaused = false;
      pauseTimeAssigned = false;
      pauseTotalMillis = 0;
    }
  }

  void pause() {
    if (!isPaused) {
      pauseBufferMillis = millis();
      isPaused = true;
    }
  }

  //Changes the duration of the timer
  void setTime(float timeInSeconds)
  {
    totalTimeMillis = timeInSeconds * 1000;
    isStarted = false;
    isPaused = true;
  }

  //Returns true of the Timer has finished running
  //If the Timer has not been started or has not finished, it will return false
  boolean isFinished()
  {
    //calculate elapsed time
    float elapsed = millis() - currTimeMillis;
    //if the timer was running and enough time has passed, return true
    if (isStarted && elapsed >= totalTimeMillis)
    {
      isStarted = false;
      return true;
    }
    return false;
  }

  //Get the remaining time in seconds.
  //Returns Timer duration if the timer has not been started yet.
  float getTimeSeconds()
  {
    float timeInSeconds = 0;
    float elapsed = millis() - currTimeMillis;

    if (!isStarted)
      return getDurationSeconds();

    if (!isPaused) {
      timeInSeconds = (totalTimeMillis- elapsed) / 1000;
    }

    if (isPaused) {
      timeInSeconds = (totalTimeMillis - elapsed) / 1000;
      if (!pauseTimeAssigned) {
        pauseTimeAssigned = true;
        pauseTotalMillis = elapsed;
      } else if (pauseTimeAssigned) {
        timeInSeconds = (totalTimeMillis - pauseTotalMillis)/1000;
      }
      pauseBufferMillis = elapsed - pauseTotalMillis;
    }

    //println(currTimeMillis, pauseBufferMillis, elapsed);
    return timeInSeconds;
  }

  //Get the remaining time in milliseconds.
  //Returns duration if the timer has not been started yet.
  float getTimeMilliseconds()
  {
    float elapsed = millis() - currTimeMillis;


    float time = 0;
    if (!isStarted)
      time = getDurationMillis();

    if (!isPaused) {
      time = totalTimeMillis - elapsed;
    }

    if (isPaused) {
      time = pauseBufferMillis - elapsed;
    }

    println(isPaused);

    return time;
  }

  //get amount of time Timer will run in seconds
  float getDurationSeconds()
  {
    return totalTimeMillis / 1000;
  }

  //get amount of time Timer will run in milliseconds
  float getDurationMillis()
  {
    return totalTimeMillis;
  }
}
