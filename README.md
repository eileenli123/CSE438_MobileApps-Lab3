# CSE438_MobileApps-Lab3

Note: pinch and rotate only works in move mode. Touch down during draw will create a new shape not resize or rotate. 

creative ideas:
- erase partial (where mouse is) 
- Save image


creative completed: 
- custom color: 
    - When the user opens the color well and changes the color, it will change the current selected color btn to be the selected color. 
- Undo btn:
    - After the user draws anything, an undo btn will pop up on the top left corner, where it will revert the drawing to what it was before the most recent move. 

EC Completed: 
- Implement two subclasses of Shape, SolidShape and OutlineShape, each with a
unique draw method. Using these classes, allow for drawing of three different shapes, either solid or outlined.
    - Toggling the swicth next to the shape will change the state. On: Filled. Off: Outline


UI Updates: 
- change shape to actual shape 
- mouse changes depending on mode
