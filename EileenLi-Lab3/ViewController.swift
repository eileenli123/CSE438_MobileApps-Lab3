//
//  ViewController.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/18/26.
//

import UIKit

class ViewController: UIViewController {
    //Reminder: make an array and just add one subview (instead of creating a new subview for every shape)

    var selectedShapeType = "Circle"
    var currShapeCenter = CGPoint(x: 0, y: 0)
    var currShape: Shape?
    
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
        print("new \(self.selectedShapeType)")
        switch self.selectedShapeType {
            case "Circle":
                currShape = Circle( origin:touchPoint, color: currColor)
            case "Square":
                currShape = Square( origin:touchPoint, color: currColor)
            case "Triangle":
                currShape = Triangle( origin:touchPoint, color: currColor)
            default:
                break
        }
        
        //add shape to array
        if let newCircle = currShape {
            drawingCanvas?.items.append(newCircle)
        }
     
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)

        let distance = Functions.distance(a: touchPoint, b: (currShapeCenter))
        
        currShape?.size = CGFloat(distance)
        
        drawingCanvas.setNeedsDisplay()

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("ended at \(touchPoint)")
        
        drawingCanvas.setNeedsDisplay()
        
    }


    @IBAction func shapeSelectorChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
            case 0:
                print("Circle selected")
                selectedShapeType = "Circle"
            case 1:
                print("Square selected")
                self.selectedShapeType = "Square"
            case 2:
                print("Triangle selected")
                self.selectedShapeType = "Triangle"
            default:
                break
        }
    }
    
    @IBAction func colorSelectorChanged(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
            case 0:
            self.currColor = .red
            case 1:
            self.currColor = .yellow
            case 2:
            self.currColor = .green
            case 3:
            self.currColor = .blue
            case 4:
            self.currColor = .purple
            
            default:
                break
        }
        
    }
    
    @IBAction func ClearScreen(_ sender: Any) {
        drawingCanvas?.items = []
    }
}

