class Column {
  float x;
  float w;
  float mouseOffset;
  float sMouseOffset;
  float mouseSnap;
  int number;
  int total;

  Column(int t, float x, float w) {
    this.mouseOffset = 0;
    this.sMouseOffset = 0;
    this.mouseSnap = 0;
    this.number = 0;
    this.total = t;
    this.x = x;
    this.w = w;
  }

  void Update() {
    push();
    for (int i = 0; i < total; i++) {
      fill(255);
      textSize(tSize);
      int wrap = int(((height/2+ (i)*tSize)+sMouseOffset) + tSize*total*1000)% int(tSize*total);
      text(nf(i, 2), x, wrap);
    }

    mouseSnap = floor(mouseOffset/tSize) * tSize;

    if (mousePressed) {
      sMouseOffset = lerp(sMouseOffset, mouseOffset, .1);
    } 
    
    if (!mousePressed || (mouseX < x-w/2|| mouseX > x+w/2)) {
      sMouseOffset = lerp(sMouseOffset, mouseSnap, .1);
      mouseOffset = mouseSnap;
    }

    number = round(total/2-sMouseOffset/tSize);
    number %= total;
    if(number < 0) number += total;
    pop();
  }

  void CheckMouse() {
    if (mouseX > x-w/2 && mouseX < x+w/2) {
      mouseOffset += mouseY - pmouseY;
    }
  }
}
