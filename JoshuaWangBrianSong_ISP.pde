// Name: Joshua Wang 
// Date: 5/10/22
// Teacher: Ms. Basaraba 
// Description: 

// declaration section
//IMPORTANT

int screenIndex = 456; //change this variable to 456 to access the pixel art

//***

PFont titleFont, wordFont, errorFont;
color backgroundMerge1, backgroundMerge2, errorMerge1, errorMerge2, wall, helmet, star, starShadow, highlight, complete; //different colors used throughout the program
int astroRotate = 0, astroX = 400, astroY = 250; //variables to move the astronaut's body
int astroRightFootX = 0, astroRightFootY = 0, astroLeftFootX = 0, astroLeftFootY = 0; //variables to move the astronaut's feet
int astroRightHandX = 0, astroRightHandY = 0, astroLeftHandX = 0, astroLeftHandY = 0; //variables to move the astronaut's hands
int astro1XDirection = 1, astro1YDirection = 1; //the direction that the astronaut bounces in for the title screen
int rotationSlide2Count = 0; //the angle at which the lights rotate at
float extensionSlide2Count = 0; //the extra extension which the lights receive, matched with a sin function to create an expanding and contracting motion
color colorSwitchSlide2 = color(0); //flashes the color of "LOW FUEL" on slide 2
color colorSwitchSlide3 = color(229, 39, 39); //flashes the color of "ERROR" on slide 3
int exitColor = 255; //background color for when the user leaves the game
int exitVariable = 255; //variable for when the game closes
int astro1X = 0; //astronaut's current X location, which changes according to astro1XDirection
int astro1Y = 0; //astronaut's current Y location, which changes according to astro1YDirection
int slide2WheelRotate = 0; //the rotation of the wheel on slide 2 (must be rotated counterclockwise)
float fluidY = -262.5; //the fluid's y level as it comes down
float fluidFillY = 340; //the fluid's Y level as it begins to rise in the tank
float fluidCoverFillY = 340; //also draws the fluid's Y level, but it uses a non-curved rectangle to cover up gaps
boolean tankFill2 = false; //boolean to check if the fuel tank is completely full
int[][] starOrMoonOrPlanet = new int[7][3]; //2D array to draw out the motif of stars, moons and planets
int shifter = 250; //variable that moves the astronaut's hands in a shrugging motion on slide 3 (navigation counting task)
int finStars, finMoons, finPlanets; //three variables that count the total number of stars, moons and planets as the starOrMoonOrPlanet array stops
int userStars, userMoons, userPlanets; //three variables that allow the user to count the stars, moons and planets
int correctGuessSlide3 = 0; //this variable works as a 3-way boolean, -1 means the user lost, 0 means it is neutral, and 1 means that the user won
boolean astroSlide3Dir = true;
int astroSlide3Pos = 400;
int lose3Frame = 0;
boolean lose3FrameSwitch = false;

// setup method
void setup(){
  size(800, 500);
  frameRate(60);
  // loads all the variables with values
  titleFont = createFont("Dosis-ExtraBold.ttf", 72); // used for large and concise texts, such as titles and subtitles
  wordFont = createFont("JosefinSans-Medium.ttf", 72); // more casual font, used for large blocks of text
  errorFont = createFont("ReactiveAnchor-L3L0n.ttf", 72); //serious font, used for error messages when the user loses
  backgroundMerge1 = color(14, 36, 100);
  backgroundMerge2 = color(18, 20, 19);
  errorMerge1 = color(0, 0, 0); 
  errorMerge2 = color(229, 39, 39);
  star = color(108, 141, 237, 200);
  starShadow = color(173, 194, 255, 100);
  highlight = color(252, 140, 54);
  complete = color(35, 229, 59);
}

void draw(){
  if (screenIndex == -1){
    frameRate(15);
    quitScreen();
    exitVariable -= 2;
    if (exitVariable <= 0){
      exit();
    }
  } else if (screenIndex == 0){
    frameRate(60);
    splashScreen();
  } else if (screenIndex == 1){
    frameRate(60);
    slide1();
  } else if (screenIndex == 2){
    frameRate(100);
    slide2();
  } else if (screenIndex == 3){
    slide3();
  } else if (screenIndex == -3){
    loseSlide3();
  } else if (screenIndex == 456){
    pixelArt();
  }
  text(mouseX + ", " + mouseY, mouseX, mouseY);
}

// method for the splash screen
void splashScreen(){
  for (int i = 0; i < 1900; i += 3){
    noStroke();
    rectMode(CORNERS);
    color gradient = lerpColor(backgroundMerge1, backgroundMerge2, i/1900.0);
    fill(gradient);
    quad(i, 0, i + 15, 0, 0, 5 * i/8, 0, (5 * i/8) + 15);
   
  }
  
  // draws the stars and planets
  for (int i = 0; i < 100; i++){
    noStroke();
    float starSize = random(5, 10);
    float starX = random(0, 800);
    float starY = random(0, 500);
    
    fill(starShadow);
    ellipse(starX - starSize/50, starY - starSize/50, starSize, starSize);
    fill(star);
    ellipse(starX, starY, starSize, starSize);
  }
  
  // writes the title in the center of the screen
  textAlign(CENTER, CENTER);
  fill(255);
  textFont(titleFont);
  textSize(72);
  text("Astral Adventure", 400, 100);
  
  // writes the start and quit buttons
  textFont(wordFont);
  textSize(48);
  // branching for the start button
  if (mouseX >= 142 && mouseX <= 253 && mouseY >= 337 && mouseY <= 367){
    fill(highlight);
  }
  text("Start", 200, 350);
  
  fill(255);
  if (mouseX >= 550 && mouseX <= 645 && mouseY >= 238 && mouseY <= 365){
    fill(highlight);
  }
  text("Quit", 600, 350);
}

//code for the first slide
void slide1(){
  background(0);
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textFont(titleFont);
  textSize(48);
  text("INTRODUCTION", 400, 50);
  textFont(wordFont);
  textSize(18);
  text("You are an astronaut travelling alone in space. \n\nHowever, after a collision with some space debris, \nyou are knocked out and wake up to a blaring alarm." +
  " Time is running out, \nand your only hope is to use your emergency shuttle to return to Earth. \nHowever, you must prepare for your journey by completing tasks." + 
  "\nIt will be a long and risky adventure. \n\nBest of luck, astronaut!\n\n\nTo progress through the story, you must click \"Next\" after completing each task. \nOnce you win the game, you can access any task you would like to re-play.\nPress 'q' at anytime to quit the program.", 400, 250);
  
  //draws the astronaut on the side
  pushMatrix();
  translate(astroX, astroY);
  rotate(radians(astroRotate));
  
  //bouncing logic
  if (astroX <= 100){
    astro1XDirection = 1;
  } else if (astroX >= 700){
    astro1XDirection = -1;
  }
  
  if (astroY <= 100){
    astro1YDirection = 1;
  } else if (astroY >= 450){
    astro1YDirection = -1;
  }
  
  astroX += astro1XDirection * 2;
  astroY += astro1YDirection * 2;
  astroRotate += 1;
  
  scale(0.5);
  astronaut();
  astronautLeftHand();
  astronautRightHand();
  astronautLeftFoot();
  astronautRightFoot();
  popMatrix();
  
  textFont(wordFont);
  textSize(48);
  // branching for the start button
  if (mouseX >= 347 && mouseX <= 443 && mouseY >= 424 && mouseY <= 484){
    fill(highlight);
  }
  text("Next", 400, 460);
  fill(255);
}

void slide2(){
  //drawing the engine room
  rectMode(CORNERS);
  background(183, 183, 183);
  noStroke();
  fill(103, 95, 95);
  rect(0, 450, 800, 500);
  
  //draws the ladder
  fill(231, 232, 16);
  rect(50, 450, 60, 100);
  rect(100, 450, 110, 100);
  
  for (int i = 400; i >= 150; i-=50){
    rect(55, i, 105, i - 10);
  }
  
  fill(255);
  strokeWeight(3);
  stroke(0);
  rectMode(CORNERS);
  rect(480, 385, 470, 450);
  rect(620, 385, 630, 450);
  
  rectMode(CENTER);
  //draws the tank
  strokeWeight(7);
  rect(550, 300, 300, 180, 50);
  
  pushMatrix();
  translate(50, 0);
  if (frameCount % 100 == 0){
    if (colorSwitchSlide2 == color(0)){
      colorSwitchSlide2 = color(216, 48, 48);
    } else {
      colorSwitchSlide2 = color(0);
    }
  } 
  
  if (tankFill2 == false){
    pushMatrix();
    translate(50, 0);
    strokeWeight(10);
    fill(137, 135, 135);
    rectMode(CORNERS);
    rect(119, 86, 269, 287);
  
    //draws a gauge on the wall
    fill(255, 255, 237);
    strokeWeight(3);
    stroke(0);
    fill(lerp(0, 255, abs(0.5 - (frameCount % 100)/100.0)));
    ellipse(194, 161, 50, 50);

    translate(194, 161);
    if (frameCount % 25 == 0){
      rotationSlide2Count++;
    }
    extensionSlide2Count = 5 * (sin(rotationSlide2Count));
    rotate(radians(30 * (rotationSlide2Count % 12)));
    for (int i = 0; i < 12; i++){
      rotate(radians(30));
      strokeWeight(5);
      stroke(lerp(-100, 255, i/11.0), 0, lerp(-100, 225, i/11.0));
      line(0, 50 + extensionSlide2Count, 0, 40 + extensionSlide2Count);
    }
    popMatrix();
  
    pushMatrix();
    translate(50, 0);
    //draws a sign under the light
    stroke(232, 72, 54);
    fill(0);
    rectMode(CENTER);
    rect(194, 250, 80, 40, 155);
    textAlign(CENTER, CENTER);
    
    fill(colorSwitchSlide2);
    textFont(wordFont);
    textSize(12);
    text("LOW FUEL", 194, 250);
    popMatrix();
    popMatrix();
  } else {
    pushMatrix();
    translate(50, 0);
    strokeWeight(10);
    fill(137, 135, 135);
    rectMode(CORNERS);
    rect(119, 86, 269, 287);
  
    //draws a gauge on the wall
    fill(255, 255, 237);
    strokeWeight(3);
    stroke(0);
    fill(lerp(0, 255, abs(0.5 - (frameCount % 100)/100.0)));
    ellipse(194, 161, 50, 50);

    translate(194, 161);
    if (frameCount % 25 == 0){
      rotationSlide2Count++;
    }
    
    extensionSlide2Count = 5 * (sin(rotationSlide2Count));
    rotate(radians(30 * (rotationSlide2Count % 12)));
    for (int i = 0; i < 12; i++){
      rotate(radians(30));
      strokeWeight(5);
      stroke(lerp(30, 40, i/11.0), 229, lerp(54, 64, i/11.0));
      line(0, 50 + extensionSlide2Count, 0, 40 + extensionSlide2Count);
    }
    popMatrix();
    
    pushMatrix();
    translate(50, 0);
    //draws a sign under the light
    stroke(complete);
    fill(0);
    rectMode(CENTER);
    rect(194, 250, 80, 40, 155);
    textAlign(CENTER, CENTER);
    
    fill(complete);
    textFont(wordFont);
    textSize(12);
    text("FULL", 194, 250);
    popMatrix();
    popMatrix();
  }
     
  //draws the pipe above the tank
  fill(255);
  stroke(0);
  rectMode(CENTER);
  rect(550, 150, 50, 425, 10);
  noStroke();
  
  //draws the fluid coming in through the pipe
  fill(93, 44, 5);
  rect(550, fluidY, 50, 425, 10);
  
  //draws the fluid filling up the tank
  rectMode(CORNERS);
  rect(400, fluidFillY, 700, 340, 50);
  rect(400, fluidCoverFillY, 700, 340);

  //draws in the residual fuel (still in the tank)
  beginShape();
  noStroke();
  arc(450, 340, 100, 100, HALF_PI, PI);
  rect(450, 340, 650, 390);
  arc(650, 340, 100, 100, 0, HALF_PI);
  endShape();
  
  //draws the wheel
  pushMatrix();
  translate(450, 300);
  strokeWeight(10);
  if (dist(mouseX, mouseY, 450, 300) <= 32 && astroX >= 310){
    stroke(240, 19, 19);
  } else {
    stroke(113, 3, 3);
  }
  strokeCap(ROUND);
  noFill();
  ellipse(0, 0, 50, 50);
  strokeWeight(7);
  rotate(radians(slide2WheelRotate));
  for (int i = 0; i < 6; i++){
    rotate(radians(45 * i));
    line(-35, 0, 35, 0);
  }
  popMatrix();
  
  //the astronaut walks in
  if (astroX <= 325 || astroLeftFootX <= 325 || astroRightFootX <= 325){
    astroX++;
    astroRightHandX++;
    astroLeftHandX++;
    if (frameCount % 20 == 0){
      astroLeftFootX += 20;
    } else if (frameCount % 20 == 10){
      astroRightFootX += 20;
    }

  pushMatrix();
  translate(astroX, 300);
  astronaut();
  astronautLeftHand();
  popMatrix();
  
  pushMatrix();
  translate(astroRightHandX, 300);
  astronautRightHand();
  popMatrix();
  
  pushMatrix();
  translate(astroLeftFootX, 300);
  astronautLeftFoot();
  popMatrix();
  
  pushMatrix();
  translate(astroRightFootX, 300);
  astronautRightFoot();
  popMatrix();
  } else {
    //draws everything except the right hand
    pushMatrix();
    translate(325, 300);
    astronaut();
    astronautLeftHand();
    astronautLeftFoot();
    astronautRightFoot();
    popMatrix();
    //draws the right hand
    pushMatrix();
    translate(350, 270);
    astronautRightHand();
    popMatrix();
  }
  
  if (tankFill2){
    textFont(wordFont);
    textSize(48);
    //draws this rectangle under the button
    noStroke();
    fill(0);
    rectMode(CENTER);
    rect(400, 460, 116, 74);
    
    fill(255);
    // branching for the "Next" button
    if (mouseX >= 347 && mouseX <= 443 && mouseY >= 424 && mouseY <= 484){
      fill(highlight);
    }
    text("Next", 400, 460);
  }
  
  //text at the top, explaining the task
  //note: all task texts shall be size 30, title font
  fill(255);
  textFont(titleFont);
  textSize(30);
  textAlign(LEFT, BASELINE);
  text("Task 1: Fuel Tanks", 50, 50);
}

void slide3(){
  noStroke();
  for (int i = 0; i < 800; i += 5){
    fill(lerpColor(backgroundMerge1, backgroundMerge2, i/800.0));
    rect(i, 0, i + 5, 800);
  }
  fill(242, 241, 234);
  strokeWeight(3);
  stroke(160, 156, 137);
  rectMode(CORNERS);
  rect(0, 450, 800, 500);
  line(0, 475, 800, 475);
  for (int i = 0; i < 800; i += 50){
    line(i, 450, i + 15, 500);
  }
  strokeWeight(3);
  stroke(115, 115, 124);
  rect(30, 0, 770, 300);
  noStroke();
  
  //draws the stars, moons and planets
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 3; j++){
      if (starOrMoonOrPlanet[i][j] == 1){
        pushMatrix();
        translate((i * 100) + 105, (j * 100) + 45);
        scale(0.75);
        moon();
        popMatrix();
      } else if (starOrMoonOrPlanet[i][j] == 2){
        pushMatrix();
        translate((i * 100) + 100, (j * 100));
        star();
        popMatrix();
      } else if (starOrMoonOrPlanet[i][j] == 3){
        pushMatrix();
        translate((i * 100) + 95, (j * 100) + 40);
        planet();
        popMatrix();
      }
    }
  } 
  //the astronaut walks in
  if (astroX < 400 || astroLeftFootX < 400 || astroRightFootX < 400){
    for (int i = 100; i <= 700; i += 100){
      for (int j = 100; j < 400; j += 100){
        float rand = random(0, 1);
        if (rand < 0.33){
          //1 equals to moon, 2 equals to star, 3 equals to planet
          starOrMoonOrPlanet[(i/100) - 1][(j/100) - 1] = 1;
        } else if (rand < 0.66 && rand >= 0.33){
          starOrMoonOrPlanet[(i/100) - 1][(j/100) - 1] = 2;
        } else {
          starOrMoonOrPlanet[(i/100) - 1][j/100 - 1] = 3;
        }
      } 
    }
  
    astroX++;
    astroRightHandX++;
    astroLeftHandX++;
    if (frameCount % 20 == 0){
      astroLeftFootX += 20;
    } else if (frameCount % 20 == 10){
      astroRightFootX += 20;
    } 

  pushMatrix();
  translate(astroX, 300);
  astronaut();
  astronautLeftHand();
  popMatrix();
  
  pushMatrix();
  translate(astroRightHandX, 300);
  astronautRightHand();
  popMatrix();
  
  pushMatrix();
  translate(astroLeftFootX, 300);
  astronautLeftFoot();
  popMatrix();
  
  pushMatrix();
  translate(astroRightFootX, 300);
  astronautRightFoot();
  popMatrix();
  } else if (correctGuessSlide3 == 0){
    //variable that allows the astronaut's hands to move
    if (frameCount % 25 == 0){
      if (shifter == 275){
        shifter = 325;
      } else {
        shifter = 275;
      }
    }
    pushMatrix();
    translate(astroX, 300);
    astronaut();
    astronautLeftFoot();
    astronautRightFoot();
    popMatrix();
    //creates animation for astronaut hands moving
    pushMatrix();
    translate(astroX, shifter);
    //left hand moves up by shifter
    astronautLeftHand();
    popMatrix();
    pushMatrix();
    translate(astroX, 600 - shifter);
    //right hand moves down by the opposite of shifter
    astronautRightHand();
    popMatrix();
      //counts the stars, moons, and planets
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 3; j++){
        if (starOrMoonOrPlanet[i][j] == 1){
          finMoons++;
        } else if (starOrMoonOrPlanet[i][j] == 2){
          finStars++;
        } else if (starOrMoonOrPlanet[i][j] == 3){
          finPlanets++;
        }
      }
    }
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 3; j++){
        if (starOrMoonOrPlanet[i][j] == 1){
          pushMatrix();
          translate((i * 100) + 105, (j * 100) + 45);
          scale(0.75);
          moon();
          popMatrix();
        } else if (starOrMoonOrPlanet[i][j] == 2){
          pushMatrix();
          translate((i * 100) + 100, (j * 100));
          star();
          popMatrix();
        } else if (starOrMoonOrPlanet[i][j] == 3){
          pushMatrix();
          translate((i * 100) + 95, (j * 100) + 40);
          planet();
          popMatrix();
        }
      }
    }
    println("Stars: " + finStars + "\nMoons: " + finMoons + "\nPlanets: " + finPlanets);
    String readerString = ""; //variable that allows user input to be converted to a string first
    if (correctGuessSlide3 != -1){
       while (true){
          readerString = getString("How many stars are there?");
        try {
          userStars = Integer.parseInt(readerString);
          break;
        } catch (Exception NumberFormatException){
          System.err.println("Input must be an integer");
        } 
      }
      if (userStars != finStars){
        correctGuessSlide3 = -1;
      }
    } if (correctGuessSlide3 != -1){
       while (true){
          readerString = getString("How many moons are there?");
        try {
          userMoons = Integer.parseInt(readerString);
          break;
        } catch (Exception NumberFormatException){
          System.err.println("Input must be an integer");
        } 
      }
       if (userMoons != finMoons){
        correctGuessSlide3 = -1;
      }
    } if (correctGuessSlide3 != -1){
      while (true){
          readerString = getString("How many planets are there?");
        try {
          userMoons = Integer.parseInt(readerString);
          break;
        } catch (Exception NumberFormatException){
          System.err.println("Input must be an integer");
        } 
      }
      if (userPlanets != finPlanets){
        correctGuessSlide3 = -1;
      }
    }  
  } else if (correctGuessSlide3 == 1){
    //user won the task
  } else if (correctGuessSlide3 == -1){
    for (int i = 0; i < 800; i += 5){
      fill(lerpColor(backgroundMerge1, backgroundMerge2, i/800.0));
      rect(i, 0, i + 5, 800);
    }
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 3; j++){
        if (starOrMoonOrPlanet[i][j] == 1){
          pushMatrix();
          translate((i * 100) + 105, (j * 100) + 45);
          scale(0.75);
          moon();
          popMatrix();
        } else if (starOrMoonOrPlanet[i][j] == 2){
          pushMatrix();
          translate((i * 100) + 100, (j * 100));
          star();
          popMatrix();
        } else if (starOrMoonOrPlanet[i][j] == 3){
          pushMatrix();
          translate((i * 100) + 95, (j * 100) + 40);
          planet();
          popMatrix();
        }
      }
    }
    //draws the astronaut dancing around
    if (astroSlide3Pos <= 375){
      astroSlide3Dir = true;
    } else if (astroSlide3Pos >= 425){
      astroSlide3Dir = false;
    }
    
    if (astroSlide3Dir == true){
      astroSlide3Pos++;
    } else {
      astroSlide3Pos--;
    }
    pushMatrix();
    translate(astroSlide3Pos, 300 + (abs(sin(astroSlide3Pos) * 3)));
    astronaut();
    astronautLeftHand();
    astronautRightHand();
    astronautRightFoot();
    astronautLeftFoot();
    popMatrix();
    //text at the bottom, explaining the task
    //note: all task texts shall be size 30, title font
    if (lose3FrameSwitch == false){
      lose3Frame = frameCount;
      lose3FrameSwitch = true;
    }
    
    //writes the name of the task
    fill(255);
    textFont(titleFont);
    textSize(30);
    textAlign(LEFT, BASELINE);
    text("Task 2: Astro Counting", 500, 383);
    
    if (frameCount <= lose3Frame + 255){
      pushMatrix();
      translate(random(-10, 10), random(-10, 10));
      error();
      popMatrix();
      lose3Frame++;
    } else {
      screenIndex = -3;
    }
  }
}

void error(){
  textFont(errorFont, 30);
  noStroke();
  rectMode(CENTER);
  for (int i = 45; i >= 0; i--){
    color thisCol = lerpColor(errorMerge1, errorMerge2, ((45.0 - i)/45.0));
    fill(thisCol, i);
    rect(400, 250, 140 + i, 60 + i, 30);
  }
  fill(0);
  strokeWeight(3);
  stroke(errorMerge2);
  rect(400, 250, 140, 60, 15);
  textAlign(CENTER, CENTER);
  fill(229, 39, 39);
  text("ERROR", 400, 250);
}

void loseSlide3(){
  background(0);
  textFont(wordFont, 24);
  textAlign(CENTER, CENTER);
  textFont(titleFont, 48);
  text("GAME OVER", 400, 100);
  text("You entered the wrong number!\nYour ship's navigational route was incorrect, \nand you made crashed into a space rock.", 400, 200);
}

void moon(){
rectMode(CORNERS);
noStroke();

fill(182, 216, 31);
rect(-40, -15, -35, -10);
rect(-40, -10, -35, -5);
rect(-35, -30, -30, -25);
rect(-35, -25, -30, -20);
rect(-35, -20, -30, -15);
rect(-35, -15, -30, -10);
rect(-35, -5, -30, 0);
rect(-30, -35, -25, -30);
rect(-30, -30, -25, -25);
rect(10, -25, 15, -20);
rect(15, -20, 20, -15);
rect(20, 0, 25, 5);
rect(25, 5, 30, 10);
rect(40, -20, 45, -15);
rect(45, -15, 50, -10);

fill(212, 242, 83);
rect(-50, -15, -45, -10);
rect(-50, -10, -45, -5);
rect(-50, -5, -45, 0);
rect(-50, 0, -45, 5);
rect(-50, 5, -45, 10);
rect(-50, 10, -45, 15);
rect(-45, -25, -40, -20);
rect(-45, -20, -40, -15);
rect(-45, -15, -40, -10);
rect(-45, -10, -40, -5);
rect(-45, -5, -40, 0);
rect(-45, 0, -40, 5);
rect(-45, 5, -40, 10);
rect(-45, 10, -40, 15);
rect(-45, 15, -40, 20);
rect(-45, 20, -40, 25);
rect(-40, -35, -35, -30);
rect(-40, -30, -35, -25);
rect(-40, -25, -35, -20);
rect(-40, -20, -35, -15);
rect(-40, -5, -35, 0);
rect(-40, 0, -35, 5);
rect(-40, 5, -35, 10);
rect(-40, 10, -35, 15);
rect(-40, 15, -35, 20);
rect(-40, 20, -35, 25);
rect(-40, 25, -35, 30);
rect(-40, 30, -35, 35);
rect(-35, -40, -30, -35);
rect(-35, -35, -30, -30);
rect(-35, -10, -30, -5);
rect(-35, 0, -30, 5);
rect(-35, 5, -30, 10);
rect(-35, 10, -30, 15);
rect(-35, 15, -30, 20);
rect(-35, 20, -30, 25);
rect(-35, 25, -30, 30);
rect(-35, 30, -30, 35);
rect(-35, 35, -30, 40);
rect(-30, -40, -25, -35);
rect(-30, -25, -25, -20);
rect(-30, -20, -25, -15);
rect(-30, -15, -25, -10);
rect(-30, -10, -25, -5);
rect(-30, -5, -25, 0);
rect(-30, 0, -25, 5);
rect(-30, 5, -25, 10);
rect(-30, 10, -25, 15);
rect(-30, 15, -25, 20);
rect(-30, 20, -25, 25);
rect(-30, 25, -25, 30);
rect(-30, 30, -25, 35);
rect(-30, 35, -25, 40);
rect(-25, -45, -20, -40);
rect(-25, -40, -20, -35);
rect(-25, -35, -20, -30);
rect(-25, -30, -20, -25);
rect(-25, -25, -20, -20);
rect(-25, 0, -20, 5);
rect(-25, 5, -20, 10);
rect(-25, 10, -20, 15);
rect(-25, 15, -20, 20);
rect(-25, 20, -20, 25);
rect(-25, 25, -20, 30);
rect(-25, 30, -20, 35);
rect(-25, 35, -20, 40);
rect(-25, 40, -20, 45);
rect(-20, -45, -15, -40);
rect(-20, -40, -15, -35);
rect(-20, -35, -15, -30);
rect(-20, 10, -15, 15);
rect(-20, 15, -15, 20);
rect(-20, 20, -15, 25);
rect(-20, 25, -15, 30);
rect(-20, 30, -15, 35);
rect(-20, 35, -15, 40);
rect(-20, 40, -15, 45);
rect(-15, -50, -10, -45);
rect(-15, -45, -10, -40);
rect(-15, -40, -10, -35);
rect(-15, 20, -10, 25);
rect(-15, 25, -10, 30);
rect(-15, 30, -10, 35);
rect(-15, 35, -10, 40);
rect(-15, 40, -10, 45);
rect(-15, 45, -10, 50);
rect(-10, -50, -5, -45);
rect(-10, -45, -5, -40);
rect(-10, 25, -5, 30);
rect(-10, 30, -5, 35);
rect(-10, 35, -5, 40);
rect(-10, 40, -5, 45);
rect(-10, 45, -5, 50);
rect(-5, -50, 0, -45);
rect(-5, 30, 0, 35);
rect(-5, 35, 0, 40);
rect(-5, 40, 0, 45);
rect(-5, 45, 0, 50);
rect(0, 30, 5, 35);
rect(0, 35, 5, 40);
rect(0, 40, 5, 45);
rect(0, 45, 5, 50);
rect(5, -20, 10, -15);
rect(5, 30, 10, 35);
rect(5, 35, 10, 40);
rect(5, 40, 10, 45);
rect(5, 45, 10, 50);
rect(10, -20, 15, -15);
rect(10, -15, 15, -10);
rect(10, 35, 15, 40);
rect(10, 40, 15, 45);
rect(10, 45, 15, 50);
rect(15, 5, 20, 10);
rect(15, 35, 20, 40);
rect(15, 40, 20, 45);
rect(20, 5, 25, 10);
rect(20, 10, 25, 15);
rect(20, 35, 25, 40);
rect(20, 40, 25, 45);
rect(25, 30, 30, 35);
rect(25, 35, 30, 40);
rect(30, 30, 35, 35);
rect(30, 35, 35, 40);
rect(35, -15, 40, -10);
rect(35, 25, 40, 30);
rect(40, -15, 45, -10);
rect(40, -10, 45, -5);
rect(40, 30, 45, 35);

fill(160, 162, 152);

fill(0, 0, 0);
rect(-60, -15, -55, -10);
rect(-60, -10, -55, -5);
rect(-60, -5, -55, 0);
rect(-60, 0, -55, 5);
rect(-60, 5, -55, 10);
rect(-60, 10, -55, 15);
rect(-55, -25, -50, -20);
rect(-55, -20, -50, -15);
rect(-55, 15, -50, 20);
rect(-55, 20, -50, 25);
rect(-50, -35, -45, -30);
rect(-50, -30, -45, -25);
rect(-50, 25, -45, 30);
rect(-50, 30, -45, 35);
rect(-45, -40, -40, -35);
rect(-45, 35, -40, 40);
rect(-40, -45, -35, -40);
rect(-40, 40, -35, 45);
rect(-35, -50, -30, -45);
rect(-35, 45, -30, 50);
rect(-30, -50, -25, -45);
rect(-30, 45, -25, 50);
rect(-25, -55, -20, -50);
rect(-25, 50, -20, 55);
rect(-20, -55, -15, -50);
rect(-20, -20, -15, -15);
rect(-20, -15, -15, -10);
rect(-20, -10, -15, -5);
rect(-20, -5, -15, 0);
rect(-20, 50, -15, 55);
rect(-15, -60, -10, -55);
rect(-15, -30, -10, -25);
rect(-15, -25, -10, -20);
rect(-15, -20, -10, -15);
rect(-15, -15, -10, -10);
rect(-15, -10, -10, -5);
rect(-15, -5, -10, 0);
rect(-15, 0, -10, 5);
rect(-15, 5, -10, 10);
rect(-15, 55, -10, 60);
rect(-10, -60, -5, -55);
rect(-10, -35, -5, -30);
rect(-10, -30, -5, -25);
rect(-10, -25, -5, -20);
rect(-10, -20, -5, -15);
rect(-10, -10, -5, -5);
rect(-10, -5, -5, 0);
rect(-10, 0, -5, 5);
rect(-10, 5, -5, 10);
rect(-10, 10, -5, 15);
rect(-10, 15, -5, 20);
rect(-10, 55, -5, 60);
rect(-5, -60, 0, -55);
rect(-5, -40, 0, -35);
rect(-5, -35, 0, -30);
rect(-5, -25, 0, -20);
rect(-5, -20, 0, -15);
rect(-5, -15, 0, -10);
rect(-5, -10, 0, -5);
rect(-5, -5, 0, 0);
rect(-5, 0, 0, 5);
rect(-5, 5, 0, 10);
rect(-5, 10, 0, 15);
rect(-5, 15, 0, 20);
rect(-5, 20, 0, 25);
rect(-5, 55, 0, 60);
rect(0, -60, 5, -55);
rect(0, -45, 5, -40);
rect(0, -40, 5, -35);
rect(0, -35, 5, -30);
rect(0, -30, 5, -25);
rect(0, -25, 5, -20);
rect(0, -20, 5, -15);
rect(0, -15, 5, -10);
rect(0, -10, 5, -5);
rect(0, -5, 5, 0);
rect(0, 5, 5, 10);
rect(0, 10, 5, 15);
rect(0, 15, 5, 20);
rect(0, 20, 5, 25);
rect(0, 55, 5, 60);
rect(5, -60, 10, -55);
rect(5, -45, 10, -40);
rect(5, -40, 10, -35);
rect(5, -35, 10, -30);
rect(5, -30, 10, -25);
rect(5, -25, 10, -20);
rect(5, -15, 10, -10);
rect(5, -10, 10, -5);
rect(5, -5, 10, 0);
rect(5, 0, 10, 5);
rect(5, 5, 10, 10);
rect(5, 10, 10, 15);
rect(5, 15, 10, 20);
rect(5, 20, 10, 25);
rect(5, 55, 10, 60);
rect(10, -60, 15, -55);
rect(10, -50, 15, -45);
rect(10, -45, 15, -40);
rect(10, -40, 15, -35);
rect(10, -35, 15, -30);
rect(10, -30, 15, -25);
rect(10, -10, 15, -5);
rect(10, -5, 15, 0);
rect(10, 0, 15, 5);
rect(10, 5, 15, 10);
rect(10, 15, 15, 20);
rect(10, 20, 15, 25);
rect(10, 25, 15, 30);
rect(10, 55, 15, 60);
rect(15, -55, 20, -50);
rect(15, -50, 20, -45);
rect(15, -45, 20, -40);
rect(15, -40, 20, -35);
rect(15, -30, 20, -25);
rect(15, -25, 20, -20);
rect(15, -15, 20, -10);
rect(15, -10, 20, -5);
rect(15, -5, 20, 0);
rect(15, 0, 20, 5);
rect(15, 10, 20, 15);
rect(15, 15, 20, 20);
rect(15, 20, 20, 25);
rect(15, 25, 20, 30);
rect(15, 50, 20, 55);
rect(20, -55, 25, -50);
rect(20, -50, 25, -45);
rect(20, -45, 25, -40);
rect(20, -40, 25, -35);
rect(20, -35, 25, -30);
rect(20, -30, 25, -25);
rect(20, -25, 25, -20);
rect(20, -20, 25, -15);
rect(20, -15, 25, -10);
rect(20, -10, 25, -5);
rect(20, -5, 25, 0);
rect(20, 15, 25, 20);
rect(20, 20, 25, 25);
rect(20, 25, 25, 30);
rect(20, 50, 25, 55);
rect(25, -50, 30, -45);
rect(25, -45, 30, -40);
rect(25, -40, 30, -35);
rect(25, -35, 30, -30);
rect(25, -30, 30, -25);
rect(25, -25, 30, -20);
rect(25, -20, 30, -15);
rect(25, -15, 30, -10);
rect(25, -5, 30, 0);
rect(25, 0, 30, 5);
rect(25, 10, 30, 15);
rect(25, 15, 30, 20);
rect(25, 20, 30, 25);
rect(25, 45, 30, 50);
rect(30, -50, 35, -45);
rect(30, -45, 35, -40);
rect(30, -40, 35, -35);
rect(30, -30, 35, -25);
rect(30, -25, 35, -20);
rect(30, -20, 35, -15);
rect(30, -15, 35, -10);
rect(30, -10, 35, -5);
rect(30, -5, 35, 0);
rect(30, 0, 35, 5);
rect(30, 5, 35, 10);
rect(30, 10, 35, 15);
rect(30, 15, 35, 20);
rect(30, 20, 35, 25);
rect(30, 45, 35, 50);
rect(35, -45, 40, -40);
rect(35, -40, 40, -35);
rect(35, -35, 40, -30);
rect(35, -30, 40, -25);
rect(35, -25, 40, -20);
rect(35, -20, 40, -15);
rect(35, -10, 40, -5);
rect(35, -5, 40, 0);
rect(35, 0, 40, 5);
rect(35, 10, 40, 15);
rect(35, 15, 40, 20);
rect(35, 40, 40, 45);
rect(40, -40, 45, -35);
rect(40, -35, 45, -30);
rect(40, -30, 45, -25);
rect(40, -25, 45, -20);
rect(40, -5, 45, 0);
rect(40, 0, 45, 5);
rect(40, 5, 45, 10);
rect(40, 10, 45, 15);
rect(40, 15, 45, 20);
rect(40, 35, 45, 40);
rect(45, -35, 50, -30);
rect(45, -30, 50, -25);
rect(45, -25, 50, -20);
rect(45, -20, 50, -15);
rect(45, -10, 50, -5);
rect(45, -5, 50, 0);
rect(45, 0, 50, 5);
rect(45, 5, 50, 10);
rect(45, 10, 50, 15);
rect(45, 15, 50, 20);
rect(45, 20, 50, 25);
rect(45, 25, 50, 30);
rect(45, 30, 50, 35);
rect(50, -25, 55, -20);
rect(50, -20, 55, -15);
rect(50, -15, 55, -10);
rect(50, -10, 55, -5);
rect(50, -5, 55, 0);
rect(50, 0, 55, 5);
rect(50, 5, 55, 10);
rect(50, 10, 55, 15);
rect(50, 15, 55, 20);
rect(50, 20, 55, 25);
rect(55, -15, 60, -10);
rect(55, -10, 60, -5);
rect(55, 0, 60, 5);
rect(55, 5, 60, 10);
rect(55, 10, 60, 15);

fill(208, 41, 211);

fill(0, 120, 120);
rect(-55, -15, -50, -10);
rect(-55, -10, -50, -5);
rect(-55, -5, -50, 0);
rect(-55, 0, -50, 5);
rect(-55, 5, -50, 10);
rect(-55, 10, -50, 15);
rect(-50, -25, -45, -20);
rect(-50, -20, -45, -15);
rect(-50, 15, -45, 20);
rect(-50, 20, -45, 25);
rect(-45, -35, -40, -30);
rect(-45, -30, -40, -25);
rect(-45, 25, -40, 30);
rect(-45, 30, -40, 35);
rect(-40, -40, -35, -35);
rect(-40, 35, -35, 40);
rect(-35, -45, -30, -40);
rect(-35, 40, -30, 45);
rect(-30, -45, -25, -40);
rect(-30, 40, -25, 45);
rect(-25, -50, -20, -45);
rect(-25, -20, -20, -15);
rect(-25, -15, -20, -10);
rect(-25, -10, -20, -5);
rect(-25, -5, -20, 0);
rect(-25, 45, -20, 50);
rect(-20, -50, -15, -45);
rect(-20, -30, -15, -25);
rect(-20, -25, -15, -20);
rect(-20, 0, -15, 5);
rect(-20, 5, -15, 10);
rect(-20, 45, -15, 50);
rect(-15, -55, -10, -50);
rect(-15, -35, -10, -30);
rect(-15, 10, -10, 15);
rect(-15, 15, -10, 20);
rect(-15, 50, -10, 55);
rect(-10, -55, -5, -50);
rect(-10, -40, -5, -35);
rect(-10, 20, -5, 25);
rect(-10, 50, -5, 55);
rect(-5, -55, 0, -50);
rect(-5, -45, 0, -40);
rect(-5, 25, 0, 30);
rect(-5, 50, 0, 55);
rect(0, -55, 5, -50);
rect(0, -50, 5, -45);
rect(0, 25, 5, 30);
rect(0, 50, 5, 55);
rect(5, -55, 10, -50);
rect(5, -50, 10, -45);
rect(5, 25, 10, 30);
rect(5, 50, 10, 55);
rect(10, -55, 15, -50);
rect(10, 30, 15, 35);
rect(10, 50, 15, 55);
rect(15, 30, 20, 35);
rect(15, 45, 20, 50);
rect(20, 30, 25, 35);
rect(20, 45, 25, 50);
rect(25, 25, 30, 30);
rect(25, 40, 30, 45);
rect(30, 25, 35, 30);
rect(30, 40, 35, 45);
rect(35, 20, 40, 25);
rect(35, 30, 40, 35);
rect(35, 35, 40, 40);
rect(40, 20, 45, 25);
}

void star(){
rectMode(CORNERS);

fill(245, 207, 15);
rect(-20, 70, -15, 75);
rect(-15, 65, -10, 70);
rect(-10, 60, -5, 65);
rect(-5, 60, 0, 65);
rect(0, 55, 5, 60);
rect(5, 55, 10, 60);
rect(10, 60, 15, 65);
rect(15, 60, 20, 65);
rect(20, 40, 25, 45);
rect(20, 45, 25, 50);
rect(20, 65, 25, 70);
rect(25, 35, 30, 40);
rect(25, 50, 30, 55);
rect(25, 55, 30, 60);
rect(25, 60, 30, 65);
rect(25, 70, 30, 75);
rect(30, 30, 35, 35);
rect(30, 65, 35, 70);
rect(30, 70, 35, 75);
rect(35, 25, 40, 30);

fill(234, 229, 67);
rect(-30, 25, -25, 30);
rect(-25, 25, -20, 30);
rect(-25, 30, -20, 35);
rect(-25, 65, -20, 70);
rect(-25, 70, -20, 75);
rect(-20, 25, -15, 30);
rect(-20, 30, -15, 35);
rect(-20, 35, -15, 40);
rect(-20, 50, -15, 55);
rect(-20, 55, -15, 60);
rect(-20, 60, -15, 65);
rect(-20, 65, -15, 70);
rect(-15, 25, -10, 30);
rect(-15, 30, -10, 35);
rect(-15, 35, -10, 40);
rect(-15, 40, -10, 45);
rect(-15, 45, -10, 50);
rect(-15, 50, -10, 55);
rect(-15, 55, -10, 60);
rect(-15, 60, -10, 65);
rect(-10, 20, -5, 25);
rect(-10, 25, -5, 30);
rect(-10, 30, -5, 35);
rect(-10, 35, -5, 40);
rect(-10, 40, -5, 45);
rect(-10, 45, -5, 50);
rect(-10, 50, -5, 55);
rect(-10, 55, -5, 60);
rect(-5, 10, 0, 15);
rect(-5, 15, 0, 20);
rect(-5, 20, 0, 25);
rect(-5, 25, 0, 30);
fill(0);
rect(-5, 30, 0, 40);
fill(234, 229, 67);
rect(-5, 40, 0, 45);
rect(-5, 45, 0, 50);
rect(-5, 50, 0, 55);
rect(-5, 55, 0, 60);
rect(0, 0, 5, 5);
rect(0, 5, 5, 10);
rect(0, 10, 5, 15);
rect(0, 15, 5, 20);
rect(0, 20, 5, 25);
rect(0, 25, 5, 30);
rect(0, 30, 5, 35);
rect(0, 35, 5, 40);
rect(0, 40, 5, 45);
rect(0, 45, 5, 50);
rect(0, 50, 5, 55);
rect(5, 0, 10, 5);
rect(5, 5, 10, 10);
rect(5, 10, 10, 15);
rect(5, 15, 10, 20);
rect(5, 20, 10, 25);
rect(5, 25, 10, 30);
rect(5, 30, 10, 35);
rect(5, 35, 10, 40);
rect(5, 40, 10, 45);
rect(5, 45, 10, 50);
rect(5, 50, 10, 55);
rect(10, 10, 15, 15);
rect(10, 15, 15, 20);
rect(10, 20, 15, 25);
rect(10, 25, 15, 30);
rect(10, 30, 15, 35);
rect(10, 35, 15, 40);
rect(10, 40, 15, 45);
rect(10, 45, 15, 50);
rect(10, 50, 15, 55);
rect(10, 55, 15, 60);
rect(15, 20, 20, 25);
rect(15, 25, 20, 30);
rect(15, 30, 20, 35);
rect(15, 35, 20, 40);
rect(15, 40, 20, 45);
rect(15, 45, 20, 50);
rect(15, 50, 20, 55);
rect(15, 55, 20, 60);
rect(20, 25, 25, 30);
rect(20, 30, 25, 35);
rect(20, 35, 25, 40);
rect(20, 50, 25, 55);
rect(20, 55, 25, 60);
rect(20, 60, 25, 65);
rect(25, 25, 30, 30);
rect(25, 30, 30, 35);
rect(25, 65, 30, 70);
rect(30, 25, 35, 30);

fill(0, 0, 0);
rect(-35, 20, -30, 25);
rect(-35, 25, -30, 30);
rect(-30, 20, -25, 25);
rect(-30, 30, -25, 35);
rect(-30, 65, -25, 70);
rect(-30, 70, -25, 75);
rect(-25, 20, -20, 25);
rect(-25, 35, -20, 40);
rect(-25, 50, -20, 55);
rect(-25, 55, -20, 60);
rect(-25, 60, -20, 65);
rect(-25, 75, -20, 80);
rect(-20, 20, -15, 25);
rect(-20, 40, -15, 45);
rect(-20, 45, -15, 50);
rect(-20, 75, -15, 80);
rect(-15, 20, -10, 25);
rect(-15, 70, -10, 75);
rect(-10, 10, -5, 15);
rect(-10, 15, -5, 20);
rect(-10, 65, -5, 70);
rect(-5, 0, 0, 5);
rect(-5, 5, 0, 10);
rect(-5, 65, 0, 70);
rect(0, -5, 5, 0);
rect(0, 60, 5, 65);
rect(5, -5, 10, 0);
rect(5, 60, 10, 65);
rect(10, 0, 15, 5);
rect(10, 5, 15, 10);
rect(10, 65, 15, 70);
rect(15, 10, 20, 15);
rect(15, 15, 20, 20);
rect(15, 65, 20, 70);
rect(20, 20, 25, 25);
rect(20, 70, 25, 75);
rect(25, 20, 30, 25);
rect(25, 40, 30, 45);
rect(25, 45, 30, 50);
rect(25, 75, 30, 80);
rect(30, 20, 35, 25);
rect(30, 35, 35, 40);
rect(30, 50, 35, 55);
rect(30, 55, 35, 60);
rect(30, 60, 35, 65);
rect(30, 75, 35, 80);
rect(35, 20, 40, 25);
rect(35, 30, 40, 35);
rect(35, 65, 40, 70);
rect(35, 70, 40, 75);
rect(40, 20, 45, 25);
rect(40, 25, 45, 30);
rect(0, 25, 5, 30);
}

void planet(){
  rectMode(CORNERS);
  noStroke();

fill(30, 4, 188);
rect(-20, -5, -15, 0);
rect(-20, 0, -15, 5);
rect(-20, 5, -15, 10);
rect(-15, -20, -10, -15);
rect(-15, -15, -10, -10);
rect(-15, 10, -10, 15);
rect(-15, 15, -10, 20);
rect(-10, -25, -5, -20);
rect(-10, -10, -5, -5);
rect(-10, 20, -5, 25);
rect(-5, -30, 0, -25);
rect(-5, -15, 0, -10);
rect(-5, -10, 0, -5);
rect(-5, 10, 0, 15);
rect(-5, 25, 0, 30);
rect(0, -30, 5, -25);
rect(0, 10, 5, 15);
rect(0, 15, 5, 20);
rect(0, 25, 5, 30);
rect(5, -35, 10, -30);
rect(5, 15, 10, 20);
rect(5, 30, 10, 35);
rect(10, -35, 15, -30);
rect(10, -15, 15, -10);
rect(10, 30, 15, 35);
rect(15, -35, 20, -30);
rect(15, 30, 20, 35);
rect(20, -35, 25, -30);
rect(20, -5, 25, 0);
rect(20, 30, 25, 35);
rect(25, -30, 30, -25);
rect(25, 25, 30, 30);
rect(30, -30, 35, -25);
rect(30, -10, 35, -5);
rect(30, -5, 35, 0);
rect(30, 0, 35, 5);
rect(30, 25, 35, 30);
rect(35, -25, 40, -20);
rect(35, -10, 40, -5);
rect(35, -5, 40, 0);
rect(35, 0, 40, 5);
rect(40, -20, 45, -15);
rect(40, -15, 45, -10);
rect(40, 10, 45, 15);
rect(40, 15, 45, 20);
rect(45, -10, 50, -5);
rect(45, -5, 50, 0);
rect(45, 0, 50, 5);
rect(45, 5, 50, 10);

fill(11, 224, 222);
rect(-10, -20, -5, -15);
rect(0, -25, 5, -20);
rect(0, -20, 5, -15);
rect(0, -15, 5, -10);
rect(5, -25, 10, -20);
rect(5, -20, 10, -15);
rect(5, 20, 10, 25);
rect(10, -25, 15, -20);
rect(10, 15, 15, 20);
rect(15, -30, 20, -25);
rect(15, -25, 20, -20);
rect(15, -20, 20, -15);
rect(15, -10, 20, -5);
rect(15, -5, 20, 0);
rect(20, -25, 25, -20);
rect(20, -20, 25, -15);
rect(20, -15, 25, -10);
rect(20, 20, 25, 25);
rect(25, -25, 30, -20);
rect(25, -20, 30, -15);
rect(25, -15, 30, -10);
rect(25, 5, 30, 10);
rect(30, -20, 35, -15);
rect(30, 5, 35, 10);
rect(35, -15, 40, -10);
rect(35, 5, 40, 10);
rect(40, 0, 45, 5);

fill(224, 11, 171);
rect(-25, -15, -20, -10);
rect(-20, -20, -15, -15);
rect(-20, -10, -15, -5);
rect(-5, 5, 0, 10);
rect(5, 10, 10, 15);
rect(15, 15, 20, 20);
rect(20, 15, 25, 20);
rect(30, 20, 35, 25);
rect(40, 25, 45, 30);
rect(45, 15, 50, 20);
rect(45, 20, 50, 25);

fill(27, 128, 227);
rect(-15, 0, -10, 5);
rect(-15, 5, -10, 10);
rect(-10, -15, -5, -10);
rect(-10, 5, -5, 10);
rect(-10, 10, -5, 15);
rect(-10, 15, -5, 20);
rect(-5, -25, 0, -20);
rect(-5, -20, 0, -15);
rect(-5, -5, 0, 0);
rect(-5, 15, 0, 20);
rect(-5, 20, 0, 25);
rect(0, -10, 5, -5);
rect(0, -5, 5, 0);
rect(0, 20, 5, 25);
rect(5, -30, 10, -25);
rect(5, -15, 10, -10);
rect(5, -10, 10, -5);
rect(5, -5, 10, 0);
rect(5, 0, 10, 5);
rect(5, 25, 10, 30);
rect(10, -30, 15, -25);
rect(10, -20, 15, -15);
rect(10, -10, 15, -5);
rect(10, -5, 15, 0);
rect(10, 0, 15, 5);
rect(10, 20, 15, 25);
rect(10, 25, 15, 30);
rect(15, -15, 20, -10);
rect(15, 0, 20, 5);
rect(15, 5, 20, 10);
rect(15, 20, 20, 25);
rect(15, 25, 20, 30);
rect(20, -30, 25, -25);
rect(20, -10, 25, -5);
rect(20, 0, 25, 5);
rect(20, 5, 25, 10);
rect(20, 25, 25, 30);
rect(25, -10, 30, -5);
rect(25, -5, 30, 0);
rect(25, 0, 30, 5);
rect(25, 10, 30, 15);
rect(25, 20, 30, 25);
rect(30, -25, 35, -20);
rect(30, -15, 35, -10);
rect(30, 10, 35, 15);
rect(35, -20, 40, -15);
rect(35, 10, 40, 15);
rect(40, -10, 45, -5);
rect(40, -5, 45, 0);
rect(40, 5, 45, 10);

fill(250, 111, 220);
rect(-25, -25, -20, -20);
rect(-25, -20, -20, -15);
rect(-20, -25, -15, -20);
rect(-20, -15, -15, -10);
rect(-15, -25, -10, -20);
rect(-15, -10, -10, -5);
rect(-15, -5, -10, 0);
rect(-10, -5, -5, 0);
rect(-10, 0, -5, 5);
rect(-5, 0, 0, 5);
rect(0, 0, 5, 5);
rect(0, 5, 5, 10);
rect(5, 5, 10, 10);
rect(10, 5, 15, 10);
rect(10, 10, 15, 15);
rect(15, 10, 20, 15);
rect(20, 10, 25, 15);
rect(25, 15, 30, 20);
rect(30, 15, 35, 20);
rect(35, 15, 40, 20);
rect(35, 20, 40, 25);
rect(40, 20, 45, 25);
rect(45, 10, 50, 15);
rect(45, 25, 50, 30);
rect(50, 15, 55, 20);
rect(50, 20, 55, 25);
}  

  void astronaut(){
    rectMode(CENTER);
    //head of astronaut
    strokeWeight(3);
    stroke(0);
    fill(255);
    ellipse(0, 0, 100, 87.5);
    strokeWeight(1);
    fill(142);
    ellipse(0, -5, 75, 60);
    fill(59, 155, 232);
    ellipse(0, -5, 60, 45);
    
    //body of astronaut
    strokeWeight(4);
    fill(255);
    strokeWeight(2);
    rect(0, 80, 85, 100, 15);
    noStroke();
    fill(0);
    rect(0, 100, 85, 15);
    
    //draws the lights
    rectMode(CORNERS);
    fill(255, 0, 0);
    rect(-32, 47, -22, 57);
    fill(0, 255, 0);
    rect(-22, 47, -12, 57);
    fill(0, 0, 255);
    rect(-12, 46, -2, 57);
  }
  
  void astronautLeftHand(){
    fill(255);
    strokeWeight(3);
    stroke(0);
    ellipse(-75, 67, 25, 20);
  }
  
  void astronautRightHand(){
    fill(255);
    strokeWeight(3);
    stroke(0);
    ellipse(75, 67, 25, 20);
  }
  
  void astronautLeftFoot(){
    //draws the feet
    fill(255);
    stroke(0);
    
    pushMatrix();
    translate(0, -15);
    
    beginShape();
    vertex(-38, 158);
    //fills in the lines
    noStroke();
    rect(-38, 158, -23, 173);
    rect(-50, 173, -23, 188);
    
    strokeWeight(3);
    stroke(0);
    line(-38, 158, -23, 158);
    line(-23, 188, -23, 158);
    line(-50, 188, -23, 188);
  
    //centered at (350, 430.5);
    arc(-50, 180.5, 15, 15, PI/2, PI + PI/2, OPEN);
    line(-50, 173, -38, 173);
    vertex(-38, 173);
    endShape(CLOSE);
    popMatrix();
  }
  
  void astronautRightFoot(){
    fill(255);
    stroke(0);
    
    pushMatrix();
    translate(0, -15);
    //other foot
    beginShape();
    fill(255);
    vertex(38, 158);
    //fills in the lines
    noStroke();
    rect(38, 158, 23, 173);
    rect(50, 173, 23, 188);
    
    //draws the lines
    strokeWeight(3);
    stroke(0); 
    line(38, 158, 23, 158);
    line(23, 188, 23, 158);
    line(50, 188, 23, 188);
    //centered at (350, 430.5);
    arc(50, 180.5, 15, 15, PI + PI/2, TWO_PI + PI/2, OPEN);
    line(50, 173, 38, 173);
    vertex(38, 173);
    endShape(CLOSE);
    popMatrix();
  }

void quitScreen(){
  frameRate(15);
  background(0);
  fill(exitColor);
  textAlign(CENTER, CENTER);
  exitColor -= 2;
  textSize(25);
  text("Credits: \n\nGame Design and Planning: Joshua Wang and Brian Song \n\n    Storyline Writer: Joshua Wang and Brian Song \n\n Programmers: Joshua Wang and Brian Song \n\n Created for 2022, Sem 2, ICS culminating project \n\n Thanks for playing!", 395, 230);
}

//method for a mouse click registering, differs with each slide
void mouseClicked(){
  if (screenIndex == 0 && (mouseX >= 142 && mouseX <= 253 && mouseY >= 337 && mouseY <= 367)){
    astroX = 400;
    astroY = 250;
    screenIndex = 1; //introduction slide
  } else if (screenIndex == 0 && mouseX >= 550 && mouseX <= 645 && mouseY >= 238 && mouseY <= 365){
    screenIndex = -1;  //credits slide
  } else if (screenIndex == 1 && mouseX >= 347 && mouseX <= 443 && mouseY >= 424 && mouseY <= 484){
    astroX = -30;
    astroY = 450;
    astroRightFootX = -35;
    astroRightFootY = 450;
    astroLeftFootX = -25;
    astroLeftFootY = 450;
    astroRightHandX = -30;
    astroRightHandY = 450;
    astroLeftHandX = -30;
    astroLeftHandY = 450;
    screenIndex = 2; //first task, fueling engines
  } else if (screenIndex == 2 && mouseX >= 347 && mouseX <= 443 && mouseY >= 424 && mouseY <= 484 && tankFill2 == true){
      //once the "Next" button shows up for the tank filling, and the user clicks on it, it will move to the 3rd slide
    astroX = -30;
    astroY = 450;
    astroRightFootX = -35;
    astroRightFootY = 450;
    astroLeftFootX = -25;
    astroLeftFootY = 450;
    astroRightHandX = -30;
    astroRightHandY = 450;
    astroLeftHandX = -30;
    astroLeftHandY = 450;
    screenIndex = 3;
  } else if (screenIndex == 456){
      if (mouseY < 100){
      colSelection = cols[floor(mouseX/(800.0/n))];
    } else if (mouseY >= 100){
      int xSelection = floor(mouseX/10.0);
      int ySelection = floor(mouseY/10.0);
      gridColors[xSelection][ySelection - 10] = colSelection;
    }
  }
}

//method for if a key is pressed, differs with each slide
void keyPressed(){
  if (key == 'q'){
    screenIndex = -1;
  }
  if (screenIndex == 456) {
    //r to restart
    //s to save
    if (key == 'r'){
      for (int i = 0; i < 80; i++){
        for (int j = 0; j < 40; j++){
          gridColors[i][j] = blank;
        }
      } 
    } else if (key == 's'){
      println("rectMode(CORNERS);\n");
      //iterates through each color
      for (int i = 0; i < cols.length - 1; i++){
        int red = cols[i] >> 16 & 0XFF;
        int green = cols[i] >> 8 & 0XFF;
        int blue = cols[i] & 0XFF;
        
        println("fill(" + red + ", " + green + ", " + blue + ");");
        for (int a = 0; a < 80; a++){
          for (int b = 0; b < 40; b++){
            if (gridColors[a][b] == cols[i]){
              println("rect(" + (a * 10) + ", " + (b * 10) + ", " + ((a * 10) + 10) + ", " + ((b * 10) + 10) + ");");
            }
          }
        }
        println();
      }
    }
  }
}

//method for once the mouse is held
void mouseDragged(){
  if (screenIndex == 2 && dist(mouseX, mouseY, 450, 300) <= 32 && astroX >= 310){
    // logical branching for if the wheel is being rotated clockwise
      if ((mouseX >= 450 && mouseY <= 300 && (mouseX > pmouseX || mouseY > pmouseY)) || (mouseX <= 450 && mouseY <= 300 && (mouseX > pmouseX || mouseY < pmouseY)) || 
      (mouseX <= 450 && mouseY >= 300 && (mouseX < pmouseX || mouseY < pmouseY)) || (mouseX >= 450 && mouseY >= 300 && (mouseX < pmouseX || mouseY > pmouseY))){
        slide2WheelRotate += 1;
        //moves the fluid down if it isnt all the way down yet, otherwise it starts filling the tank
        if (fluidY <= 150){
          fluidY++;
        } else if (fluidFillY >= 210){
            if (fluidCoverFillY >= 255){
              fluidCoverFillY -= 0.7;
            } else {
              tankFill2 = true;
            }
          fluidFillY--;
        }
      }    
  } else if (screenIndex == 456){
    if (mouseY >= 100){
      int xSelection = floor(mouseX/10.0);
      int ySelection = floor(mouseY/10.0);
      if (changedAlr[xSelection][ySelection - 10] == false){
        // if the grid has not been changed yet
        gridColors[xSelection][ySelection - 10] = colSelection;
        changedAlr[xSelection][ySelection - 10] = true;
      }
    }
  }
}

void mouseReleased(){
  if (screenIndex == 456){
    for (int i = 0; i < 80; i++){
      for (int j = 0; j < 40; j++){
        changedAlr[i][j] = false;
      }
    }
  }
}
