class Button {
  public PVector panelPosition;
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
  public PImage image;

  public Button(PVector position, PVector size, String text) {
    this.position = position;
    this.size = size;
    this.text = text;
  }
  
  //public Button(float x, float y, float w, float h, String text) {
  //  this.position = new PVector(x, y);
  //  this.size = new PVector(w, h);
  //  this.text = text;
  //}
  
  public Button(float x, float y, float w, float h, String pi) {
    this.position = new PVector(x, y);
    this.size = new PVector(w, h);
    this.image = loadImage(pi);
  }
  
  void SetPanel(float x, float y) {
    panelPosition = new PVector(x, y);
  }

  void Display() {
    Logic();
    if (this.image == null) {
      stroke(this.strokeColor);
      strokeWeight(1);
      this.clickedColor = color(red(fillColor) - darkerCol, green(fillColor) - darkerCol, blue(fillColor) - darkerCol);
      this.hoveredColor = color(red(fillColor) - darkCol, green(fillColor) - darkCol, blue(fillColor) - darkCol);
      rect(position.x, position.y, size.x, size.y);
      fill(textColor);
      if (centeredText) {
        textAlign(CENTER, CENTER);
        text(text, position.x + size.x/2, position.y + size.y/2);
      } else
        text(text, position.x, position.y + size.y/2);
    } else if (this.image != null) {
      pushStyle();
      this.clickedColor = color(255-darkerCol);
      this.hoveredColor = color(255-darkCol);
      image(image, position.x, position.y, size.x, size.y);
      popStyle();
    }
  }

  void Logic() {
    endClick = false;
    if (Collisions() && mousePressed) {
      isClicked = true;
      fill(clickedColor);
      tint(clickedColor);
    } else if (Collisions()) {
      if (isClicked2) endClick = true;
      isClicked = false;
      isHovered = true;
      fill(hoveredColor);
      tint(hoveredColor);
    } else {
      fill(fillColor);
      tint(255);
      isHovered = false;
      isClicked = false;
    }
    isClicked2 = isClicked;
  }

  public boolean Collisions() {
    if (panelPosition == null) {
      if (mouseX > position.x && mouseX < position.x + size.x && mouseY < position.y + size.y && mouseY > position.y) {
        return true;
      } else {
        return false;
      }
    }else {
      PVector pPosition = panelPosition.copy().add(position);
      if (mouseX > pPosition.x && mouseX < pPosition.x + size.x && mouseY < pPosition.y + size.y && mouseY > pPosition.y) {
        return true;
      } else {
        return false;
      }
    }
  }
}
