// Mr. G. Heffernan
// Date: ?
// North Toronto C.I. (Computer Science)
// Though many things were designed to work in a straight forward manner in Processing, 
// reading primitive types and Strings from the keyboard was not one of them. Because 
// of the graphical nature of Processing it was designed to have interaction mainly 
// using the mouse (which Processing makes fairly easy). It is also fairly easy to get 
// individual keystrokes from the keyboard; However, to read ints, floats, Strings, etc. 
// we will need some help. This file is that help.
//
// Open up a new blank Processing document. Go to "Sketch -> Add File..." and then choose
// the file Input.pde. There will now be 2 tabs in you new sketch with Input.pde being 
// visible. Select the *other* tab and you can type in your program there. In order to use
// the code from Input.pde in your program you will need to use the functions/methods in: 
// void setup(); void draw(); or, any other method you create.


import javax.swing.*;

String prompt(String s)
{
   println(s);
   String entry = JOptionPane.showInputDialog(s);
   if (entry == null)
      return null;
   println(entry);
   return entry;
}

String getString(String s)
{
   return prompt(s);
}

int getInt(String s)
{
   return Integer.parseInt(getString(s));
}

long getLong(String s)
{
   return Long.parseLong(getString(s));
}

float getFloat(String s)
{
   return Float.parseFloat(getString(s));
}

double getDouble(String s)
{
   return Double.parseDouble(getString(s));
}

char getChar(String s)
{
   String entry = prompt(s);
   if (entry.length() >= 1)
      return entry.charAt(0);
   else
      return '\n';
}
