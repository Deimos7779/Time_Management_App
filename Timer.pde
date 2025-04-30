  /**
 * The Timer class represents a simple countdown timer
 * to help with timed events. Timers can be started and then
 * checked as to whether they have finished or not.
 */
class Timer {
  Button start;
Button pause;
Button reset;
Button setTime;
  
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

  //Constructor: accepts the running time of the Timer in seconds.
  Timer(int timeInSeconds) 
  {
    start = new Button(width/2, height/2-50, 100, 30, "Start");
  pause = new Button(width/2, height/2-250, 100, 30, "Pause");
  reset = new Button(width/2, height/2-150, 100, 30, "Reset");
  setTime = new Button(width/2, height/2 + 150, 100, 30, "Set Time");
    setTime(timeInSeconds);
    isStarted = false;
    isPaused = true;
  }

  //Begins the Timer countdown
  void start() 
  {
    if(!isStarted) {
    currTimeMillis = millis(); 
    isStarted = true;
    isPaused = false;
    } else if (isPaused){
      currTimeMillis += pauseBufferMillis;
      isPaused = false;
      pauseTimeAssigned = false;
      pauseTotalMillis = 0;
    }
  }
  
  void pause(){
    if (!isPaused){
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
    
    if(!isPaused){
    timeInSeconds = (totalTimeMillis- elapsed) / 1000;
    }
    
    if(isPaused){
      timeInSeconds = (totalTimeMillis - elapsed) / 1000;
      if(!pauseTimeAssigned){
        pauseTimeAssigned = true;
        pauseTotalMillis = elapsed;
      } else if (pauseTimeAssigned){
        timeInSeconds = (totalTimeMillis - pauseTotalMillis)/1000;
      }
      pauseBufferMillis = elapsed - pauseTotalMillis;
    }
    
    println(currTimeMillis, pauseBufferMillis, elapsed);
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
      
    if(!isPaused){
    time = totalTimeMillis - elapsed;
    }
    
    if(isPaused){
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
