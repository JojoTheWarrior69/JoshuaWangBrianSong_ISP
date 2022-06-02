// Name: Joshua Wang
// Date: 05/26/22
// Teacher: Ms. Basaraba
// Description: Creates a program that is able to draw pixel art, and paste the result in chat

color colSelection = color(0);

// this is the section that you, as the user, must customize
int n = 4; // change this number to change the number of colors
color blank = color(255);
color[] cols = {color(245, 207, 15), color(234, 229, 67), color(0), blank};

color[][] gridColors = new color[80][40];
boolean[][] changedAlr = new boolean[80][40];


void pixelArt(){
  frameRate(15030);
  size(800, 500);
  for (int i = 0; i < 80; i++){
    for (int j = 0; j < 40; j++){
      gridColors[i][j] = blank;
    }
  }
  design();
}

void design(){
  //the first row of 800 by 100 will be split into even sections with colors
  
  //draws the color palette
  rectMode(CORNERS);
  noStroke();
  for (int i = 0; i < n; i++){
    fill(cols[i]);
    rect(i * (800.0/n), 0, (i + 1) * (800.0/n), 100);
  }  
  
  fill(colSelection);
  //lines for each rectangle
  strokeWeight(1);
  stroke(0);
  //creates the grid, 10 x 10
  for (int i = 0; i <= 790; i += 10){
    for (int j = 100; j <= 490; j += 10){
      fill(gridColors[floor(i/10.0)][floor(j/10.0) - 10]);
      rect(i, j, i + 10, j + 10);
    } 
  }
}
