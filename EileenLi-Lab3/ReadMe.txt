# CSE438_MobileApps-Lab3

Note: pinch and rotate only works in move mode. Touch down during draw will create a new shape not resize or rotate.

creative features:
- custom color palette:
    - What: I implemented a customizable color system using UIColorWell. When the user selects a new color from the color well, the currently selected color button updates to reflect that new color. This allows users to dynamically modify their palette rather than being limited to predefined colors.
    - How: The process involved a lot of trial and error. I had originally thought the ColorWell would have an IB action so I can tell when the user opens the color well and changes color, so I wanted the color well to be its own color (if there is one selected, clicking it again and closing it would be the selected color). After adding the color well, I realized UIColorWell does not support actions, so I tried adding a target to the color well that triggers a fn on click. However, it seemed to only sense .valueChanged. (I made a piazza post, but changed the idea before getting a response). Since it is able to sense when a color is changed, I decided to update the feature so that it changes the currently selected btn to be the changed value. This is also better for the user to they can create their own color scheme. To do this, I added a var that trackes the curr btn. When any color btn is clicked, it updates this ptr. If the value of the color well is changed, it would set the bg color of the curr btn to be new color. I also had to change the way I set up assigning the currColor var. Instead of hardcoding (i.e. set color to red when first btn clicked), when any color btn is clicked, it would set it to the bg color of the btn.
    - Why: This increases user flexibility. Instead of being restricted to five static colors, users can create their own palette dynamically. It transforms the app from a basic drawing tool into something more customizable and expressive.
    
- Undo btn:
    - What: An Undo button appears after the first drawing action. It restores the canvas to the state before the most recent action (draw, erase, move, duplicate).
    - How: This was the hardest feature in the app for me. I added a 2d array that tracks the list of drawingItems after every move. When a move is made, I would add a copy of the items into the array. When undo is clicked, I would pop the last move and assign items to be the version at the top of the stack. This worked for draw and erase because it stored ptrs to the shapes, so it would draw shapes based on if the ptrs existed or not. However, I realized this does not undo moves (since it is a shallow copy). I orginally tried having each shape store its history in a stack and moving to its prev history by popping of the stack, however, this wouldn't be able to tell which shape was moved in what order. To fix this, I added a copy fn to shape that makes a deep copy. This way, the location of the original shape is kept in the old version. Although this would take up more space, for the scale of the drawings in this app, there aren't too many shapes in total. If this app was to grow in size, I think this should be optimized if by making a Move object (it can track the shape obj and the changes (i.e delta x and y)). With this approach, we can have a stack of Move objs and clicking undo would make the reverse change to the shape.
    - Why: Undo is a core feature in most editing applications. Without it, mistakes are often frustrating. Implementing full undo (including move operations) significantly increases usability and mirrors professional design tools.
    
- Hold to duplicate (in draw mode)
    - What: In draw mode, the user can hold down a shape for at least 0.5 secs and release to create the a duplicate shape (slightly off center so it can be seen).
    - How: I used a UILongPressGestureRecognizer to sense when there is a long press. If there is and the user is in draw mode, it would look for the top most shape and create and new shape using the copy() fn from Shape. Since Copy, finding the topmost obj, and creating a shape has already been implemented for previous features, this feature didn't require as much work. However, since I had originally implement the draw on click in the touchesBegan fn, it would create a new shape where the long press starts and duplicate that new shape (since it would be the top shape). To fix this, I added a flag to track if it is a long press, and moved the draw on touchEnded to check if it is not a long press.
    - Why: This allows users to create identical shapes quickly without manually resizing and rotating them. It improves efficiency and adds a more advanced interaction model beyond simple drawing.
    
- Add random shapes
    - What: In any mode, at the top middle of the screen, there is a add random button that generates 5-10 random shapes
    - How: I use .random for the input values i.e. Int.random(in: 5...10). Then I created a shape with the random values and added that to items. I save the snapshot for undo after all the shapes have been added so that an undo will remove all of the shapes.
    - Why: This feature adds a creative and exploratory element to the drawing app. Instead of manually creating every shape, users can instantly generate abstract compositions that may inspire new ideas.

- hold + move mouse when intiially drawing shape to size
    - What: (class demo)When drawing a shape, the user can press and drag to dynamically size it. The final shape’s size is determined by the distance between the initial touch point and the release point.
    - How: This feature was introduced during the class demo, and although it was not explicitly required for the lab, I chose to preserve it in my final implementation. Although most of the work was done in the demo, this feature had to be considered when implementing other features. I.e. ensuring that the undo snapshot is saved only after the touch ends, so the final sized shape is captured correctly and making sure this interaction did not conflict with long-press detection for duplication.
    - Why: This allows the user to draw different size shapes more efficiently. If the user knows how big the shape should be at the time of the drawing, they wont have to switch the edit mode to resize and then back to draw and make the next shape.

EC Completed:
- Implement two subclasses of Shape, SolidShape and OutlineShape, each with a unique draw method. Using these classes, allow for drawing of three different shapes, either solid or outlined.
    - Toggling the swicth next to the shape will change the state. On: Filled. Off: Outline

- Implement at least two Home Screen Actions for your app. See the image below for an example.
    - New drawing - this opens the app to a blank canvas (clears any previous work)
    - Random Draw - this clears any previous work and generates a random drawing with random shapes. 


