//
//  ViewController.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/18/26.
//

import UIKit

class ViewController: UIViewController {
    //Reminder: make an array and just add one subview (instead of creating a new subview for every shape)

    enum ShapeOptions {
        case circle
        case square
        case triangle
    }
    
    enum EditModes {
        case draw
        case move
        case erase
    }
    
    var selectedShapeType: ShapeOptions = .circle
    var selectedMode: EditModes = .draw
    
    var currShapeCenter = CGPoint(x: 0, y: 0)
    var currShape: Shape?
    
    var currColor = UIColor.red

    @IBOutlet weak var drawingCanvas: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("began at \(touchPoint)")
        
        if self.selectedMode == .draw {
            currShapeCenter = touchPoint
            print("new \(self.selectedShapeType)")
            switch self.selectedShapeType {
                case .circle:
                    currShape = Circle(origin: touchPoint, color: currColor)
                case .square:
                    currShape = Square(origin: touchPoint, color: currColor)
                case .triangle:
                    currShape = Triangle(origin: touchPoint, color: currColor)
            }
            
            //add shape to array
            if let newCircle = currShape {
                drawingCanvas?.items.append(newCircle)
            }
        } else if self.selectedMode == .erase {
            if var items = drawingCanvas?.items {
                //remove top item (last added to items)
                for i in (0..<items.count).reversed() {
                    let item = items[i]
                    if item.contains(point: touchPoint) {
                        print("remove \(i)")
                        items.remove(at: i)
                        drawingCanvas?.items = items
                        break
                    }

                }
            }
            
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.selectedMode == .draw {
            let touchPoint = touches.first!.location(in: drawingCanvas)

            let distance = Functions.distance(a: touchPoint, b: (currShapeCenter))
            
            currShape?.size = CGFloat(distance)
            
            drawingCanvas.setNeedsDisplay()
            
        }

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        print("ended at \(touchPoint)")
        
        drawingCanvas.setNeedsDisplay()
        
    }


    //TARGET ACTIONS
    @IBAction func shapeSelectorChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
            case 0:
                selectedShapeType = .circle
            case 1:
                selectedShapeType = .square
            case 2:
                selectedShapeType = .triangle
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
    
    @IBAction func editModeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                selectedMode = .draw
            case 1:
                selectedMode = .move
            case 2:
                selectedMode = .erase
            default:
                break
        }
    }
    
    @IBAction func ClearScreen(_ sender: Any) {
        drawingCanvas?.items = []
    }
}

