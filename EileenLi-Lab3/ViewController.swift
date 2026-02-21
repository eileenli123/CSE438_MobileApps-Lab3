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
    
    
    @IBOutlet weak var ColorWell: UIColorWell!
    
    @IBOutlet weak var SelectedColorBG: UIView!
    @IBOutlet weak var RedBtn: UIButton!
    @IBOutlet weak var YellowBtn: UIButton!
    
    
    
    
    //drawing selections
    var selectedShapeType: ShapeOptions = .circle
    var selectedMode: EditModes = .draw
    
    var selectedColorButton: UIButton?
    
    var currColor = UIColor.red
    
    var filledShape = true
    
    var colorWellColor : UIColor?
    var currShapeCenter = CGPoint(x: 0, y: 0)
    var currShape: Shape?
    
    var startMoveTouchPoint: CGPoint? = CGPoint(x: 0, y: 0)

    @IBOutlet weak var drawingCanvas: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
 
        // Pinch Gesture for resizing
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        drawingCanvas?.addGestureRecognizer(pinchGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        drawingCanvas?.addGestureRecognizer(rotationGestureRecognizer)
        
        
        self.view.sendSubviewToBack(SelectedColorBG)
        
        selectedColorButton = RedBtn

        ColorWell.addTarget(self,action: #selector(colorWellColorChanged(_:)),for: .valueChanged)
        
  
    }
    
    
    @objc func colorWellColorChanged(_ sender: UIColorWell) {
        print("Color well color changed")
        //set curr color btn to new color
        currColor = sender.selectedColor ?? .black

        if let selectedColorButton = selectedColorButton,
           var config = selectedColorButton.configuration {

            config.background.backgroundColor = currColor
            selectedColorButton.configuration = config
        }
    }
    

    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if selectedMode == .move, let shape = currShape {
            shape.size *= sender.scale
            sender.scale = 1 // reset scale to precent continuous scaling
            drawingCanvas?.setNeedsDisplay()
        }
    }
    
    @objc func handleRotation(_ sender: UIRotationGestureRecognizer) {
        if selectedMode == .move, let shape = currShape {
            print("rotating to \(sender.rotation)")
            shape.rotation += sender.rotation
            sender.rotation = 0  // Reset rotation to prevent continuous rotation
            drawingCanvas?.setNeedsDisplay()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        
        if self.selectedMode == .draw {
            currShapeCenter = touchPoint
            print("new \(self.selectedShapeType)")
            switch self.selectedShapeType {
                case .circle:
                    currShape = Circle(origin: touchPoint, color: currColor, isFilled: filledShape)
                case .square:
                    currShape = Square(origin: touchPoint, color: currColor, isFilled: filledShape)
                case .triangle:
                    currShape = Triangle(origin: touchPoint, color: currColor, isFilled: filledShape)
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
        } else if self.selectedMode == .move {
            if let items = drawingCanvas?.items {
                //track which item to be moved
                for i in (0..<items.count).reversed() {
                    let item = items[i]
                    if item.contains(point: touchPoint) {
                        print("move \(i)")
                        startMoveTouchPoint = touchPoint

                        // safely cast item to Shape before assigning to currShape
                        if let shapeItem = item as? Shape {
                            currShape = shapeItem
                            currShapeCenter = shapeItem.center
                        }

                        break
                    }
                }
            }
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: drawingCanvas)
        
        if self.selectedMode == .draw {
            
            let distance = Functions.distance(a: touchPoint, b: (currShapeCenter))
            
            currShape?.size = CGFloat(distance)
            
            
            
        } else if self.selectedMode == .move && currShape != nil && startMoveTouchPoint != nil{
            //move the same distance as mouse move
            let deltaX = startMoveTouchPoint!.x - touchPoint.x
            let deltaY = startMoveTouchPoint!.y - touchPoint.y
            
            //move curr shape center (unwrapped since if statement checks not nil)
            currShapeCenter = CGPoint(x: currShapeCenter.x - deltaX, y: currShapeCenter.y - deltaY)
            currShape?.center = currShapeCenter
       
            startMoveTouchPoint = touchPoint

        }
        
        //keep updating drawing as shape is moving 
        drawingCanvas.setNeedsDisplay()

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touchPoint = touches.first!.location(in: drawingCanvas)
        
        startMoveTouchPoint = nil
        currShape = nil
        drawingCanvas.setNeedsDisplay()
    }
    
    //Helper for any color btn clicked
    func colorBtnClicked(_ sender: UIButton){
        // Set the background view to match the button's position
        let buttonFrame = sender.frame
        SelectedColorBG.frame = CGRect(x: buttonFrame.minX-5, y: buttonFrame.minY-5, width: buttonFrame.size.width+10, height: buttonFrame.size.height+10)
        
        selectedColorButton = sender
        
        if let config = sender.configuration {
            currColor = config.background.backgroundColor ?? .black
        }
        
        self.view.sendSubviewToBack(SelectedColorBG)
    }
    

    //TARGET ACTIONS
    @IBAction func FirstColorBtnClicked(_ sender: UIButton) {
        colorBtnClicked(sender)
    }
    
    @IBAction func SecondColorBtnClicked(_ sender: UIButton) {
        colorBtnClicked(sender)
    }
    
    @IBAction func ThirdColorBtnClicked(_ sender: UIButton) {
        colorBtnClicked(sender)
    }
    
    @IBAction func FourthColorBtnClicked(_ sender: UIButton) {
        colorBtnClicked(sender)
    }
    
    @IBAction func FifthColorBtnClicked(_ sender: UIButton) {
        colorBtnClicked(sender)
    }
    
    
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
    

    
    @IBAction func fillToggleChanged(_ sender: UISwitch) {
        self.filledShape = sender.isOn
    }
    
    @IBAction func ClearScreen(_ sender: Any) {
        drawingCanvas?.items = []
    }
}

