String searchText = "";
int searchBarX = 50;
int searchBarY = 50;
int searchBarWidth = 300;
int searchBarHeight = 40;
boolean isTyping = false;
String searchedCity;

String[] states = {"Alabama (AL)", "Alaska (AK)", "Arizona (AZ)", "Arkansas (AR)", "California (CA)", 
                    "Colorado (CO)", "Connecticut (CT)", "Delaware (DE)", "Florida (FL)", 
                    "Georgia (GA)", "Hawaii (HI)", "Idaho (ID)", "Illinois (IL)", "Indiana (IN)", 
                    "Iowa (IA)", "Kansas (KS)", "Kentucky (KY)", "Louisiana (LA)", "Maine (ME)",
                    "Maryland (MD)", "Massachusetts (MA)", "Michigan (MI)", "Minnesota (MN)", 
                    "Mississippi (MS)", "Missouri (MO)", "Montana (MT)", "Nebraska (NE)", 
                    "Nevada (NV)", "New Hampshire (NH)", "New Jersey (NJ)", "New Mexico (NM)",
                    "New York (NY)", "North Carolina (NC)", "North Dakota (ND)", "Ohio (OH)",
                    "Oklahoma (OK)", "Oregon (OR)", "Pennsylvania (PA)", "Rhode Island (RI)",
                    "South Carolina (SC)", "South Dakota (SD)", "Tennessee (TN)", "Texas (TX)",
                    "Utah (UT)", "Vermont (VT)", "Virginia (VA)", "Washington (WA)", 
                    "West Virginia (WV)", "Wisonsin (WI)", "Wyoming (WY)"};
int[] stateYPositions = new int[states.length];

void setup()
{
  size(400, 400);
}

void draw() 
{
  background(50);
  
  stroke(0);
  fill(240);
  rect(searchBarX, searchBarY, searchBarWidth, searchBarHeight);
  
  fill(0);
  textSize(20);
  text(searchText, searchBarX + 10, searchBarY + 30);
  
  if (isTyping && frameCount % 60 < 30) 
  {
    float cursorX = searchBarX + 10 + textWidth(searchText);
    line(cursorX, searchBarY + 10, cursorX, searchBarY + 30);
  }
  
  fill(0);
  textSize(16);
  int yOffset = 120;
  for (int i = 0; i < states.length; i++) 
  {
    if (states[i].toLowerCase().contains(searchText.toLowerCase())) 
    {
      text(states[i], searchBarX + 10, yOffset);
      stateYPositions[i] = yOffset; 
      yOffset += 20;
    } 
    else 
    {
      stateYPositions[i] = -1;
    }
  }
}

void keyPressed() {
  if (isTyping) {
    if (key == BACKSPACE) 
    {
      if (searchText.length() > 0) 
      {
        searchText = searchText.substring(0, searchText.length() - 1);
      }
    } 
    else if (key != CODED && key != ENTER && key != RETURN) 
    {
      searchText += key;
    }
    
    if (key == ENTER)
    {
      searchedCity = searchText;
      print(searchedCity);
    }
  }
}

void mousePressed() {
  if (mouseX > searchBarX && mouseX < searchBarX + searchBarWidth && mouseY > searchBarY 
        && mouseY < searchBarY + searchBarHeight) 
  {
    isTyping = true;
  } 
  else 
  {
    isTyping = false;
  }
  
  for (int i = 0; i < states.length; i++) 
  {
    if (stateYPositions[i] != -1 && mouseX > searchBarX + 10 && mouseX < searchBarX + searchBarWidth 
        && mouseY > stateYPositions[i] - 15 && mouseY < stateYPositions[i] + 5) 
    {
      searchText = states[i];
      isTyping = true; 
    }
  }
}

//All code added by Joseph Hegarty 14:00 21/03/2025
