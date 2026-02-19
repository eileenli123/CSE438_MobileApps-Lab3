//
//  ViewController.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/18/26.
//

import UIKit

class ViewController: UIViewController {
    //Reminder: make an array and just add one subview (instead of creating a new subview for every shape)

    
    var currShapeCenter = CGPoint(x: 0, y: 0)
    var currShape: Circle?

    
    var currColor = UIColor.red

    @IBOutlet weak var drawingCanvas: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Only draw in the canvas
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("began at \(touchPoint)")
        
        currShapeCenter = touchPoint
        currShape = Circle(origin:touchPoint, color: currColor) //TODO: handle other shapes
        
        //add shape to array
        if let newCircle = currShape {
            drawingCanvas?.items.append(newCircle)
        }
     
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("moved to \(touchPoint)")
        
        let distance = Functions.distance(a: touchPoint, b: (currShapeCenter))
        
        currShape?.radius = CGFloat(distance)
        
        drawingCanvas.setNeedsDisplay()

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("ended at \(touchPoint)")
        
        drawingCanvas.setNeedsDisplay()
        
    }


    @IBAction func ClearScreen(_ sender: Any) {
        drawingCanvas?.items = []
    }
}

