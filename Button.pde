class Button {
  public PVector position;
  public PVector size;
  public boolean centeredText = true;
  boolean isHovered = false;
  boolean isClicked = false;
  boolean isClicked2 = false;
  boolean endClick = false;
  public color fillColor = color(255, 255, 255);
  public color strokeColor = color(0, 0, 0);
  color hoveredColor;
  color clickedColor;
  public color textColor = color(0, 0, 0);
  public String text = "";
  private float darkCol = 50;
  private float darkerCol = 100;

  public Button(PVector position, PVector size, String text) {
    this.position = position;
    this.size = size;
    this.text = text;
  }
  
  public Button(float x, float y, float w, float h, String text) {
    this.position = new PVector(x, y);
    this.size = new PVector(w, h);
    this.text = text;
  }

  void Display() {
    Logic();
    stroke(this.strokeColor);
    strokeWeight(1);
    this.clickedColor = color(red(fillColor) - darkerCol, green(fillColor) - darkerCol, blue(fillColor) - darkerCol); 
    this.hoveredColor = color(red(fillColor) - darkCol, green(fillColor) - darkCol, blue(fillColor) - darkCol);
    rect(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
    fill(textColor);
    if(centeredText){
      textAlign(CENTER,CENTER);
      text(text, position.x, position.y);
    } else
      text(text, position.x - size.x/2, position.y);
  }

  void Logic() {
    endClick = false;
    if (Collisions() && mousePressed) {
      isClicked = true;
      fill(clickedColor);
    } else if (Collisions()) {
      if(isClicked2) endClick = true;
      isClicked = false;
      isHovered = true;
      fill(hoveredColor);
    } else {
      fill(fillColor); 
      isHovered = false;
      isClicked = false;
    }
    isClicked2 = isClicked;
  }

  public boolean Collisions() {
    if (mouseX > position.x - size.x/2 && mouseX < position.x + size.x/2 && mouseY < position.y + size.y/2 && mouseY > position.y - size.y/2) {
      return true;
    } else {
      return false;
    }
  }
}
