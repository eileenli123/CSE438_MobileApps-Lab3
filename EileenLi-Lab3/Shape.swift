//
//  Shape.swift
//  CSE 4308S Lab 3
//
//  Created by Michael Ginn.
//

import UIKit

/**
 YOU SHOULD MODIFY THIS FILE.
 
 Feel free to implement it however you want, adding properties, methods, etc. Your different shapes might be subclasses of this class, or you could store information in this class about which type of shape it is. Remember that you are partially graded based on object-oriented design. You may ask TAs for an assessment of your implementation.
 */

/// A `DrawingItem` that draws some shape to the screen.
class Shape: DrawingItem {
    enum ShapeType {
        case circle
        case square
        case triangle
    }
    
    var color: UIColor
    var cachedPath: UIBezierPath?
    var selectedShape: ShapeType = .circle
    
    // delete old path when val changed
    var rotation : CGFloat { didSet { cachedPath = nil}}
    var center: CGPoint {didSet {cachedPath = nil}}
    var size: CGFloat {didSet {cachedPath = nil}}
    
    //required from drawingItem
    public required init(origin: CGPoint, color: UIColor){
        self.size = 50
        self.rotation = 0
        self.center = origin
        self.color = color
    }
    

    public init(origin: CGPoint, color: UIColor, shape: ShapeType){
        self.size = 50
        self.rotation = 0
        self.center = origin
        self.color = color
        self.selectedShape = shape
    }


    func draw() {
        fatalError("A SHAPE SHOULD BE FILLED OR OUTLINE")
    }
    
    func contains(point: CGPoint) -> Bool {
        switch self.selectedShape {
        case .circle:
            let distance = Functions.distance(a: center, b: point)
            return distance <= size
        case .square:
            //define square bounds
            let minX = center.x - size / 2
            let maxX = center.x + size / 2
            let minY = center.y - size / 2
            let maxY = center.y + size / 2
            
            //check in bounds
            return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
        case .triangle:
            let width = size * 2
            let height = width * 0.866
            
            let radius = height / 2
            
            let distance = Functions.distance(a: point, b: center)
            
            return distance <= radius
        
        }
    }
    
    // Helper function to apply rotation
    func applyRotation(to path: UIBezierPath) -> UIBezierPath {
        
        //rotated trasnform around (0,0): move shape to 0,0 --> rotate --> move back
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: rotation)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
  
        // Apply the transformation to the path
        path.apply(transform)
        
        return path
    }
    
    //helper for getting path based on shapeType
    func getShapePath() -> UIBezierPath {
        switch self.selectedShape {
        case .circle:
            return UIBezierPath(arcCenter: center, radius: size, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        case .square:
            let rect = CGRect(x: center.x - size, y: center.y - size, width: size*2, height: size*2)
            return applyRotation(to: UIBezierPath(rect: rect))
        case .triangle:
            let path = UIBezierPath()
            let xAxis = center.x
            let yAxis = center.y
            let width = size * 2    // base (same as diameter of circle)
            let height = width * 0.866    // equilateral height is approx 0.866 of base

            path.move(to: CGPoint(x: xAxis - width / 2, y: yAxis + height / 2))  // Left
            path.addLine(to: CGPoint(x: xAxis + width / 2, y: yAxis + height / 2))  // Right
            path.addLine(to: CGPoint(x: xAxis, y: yAxis - height / 2))  // Top
            path.close()
            
            return applyRotation(to: path)
        
        }
    }
}
