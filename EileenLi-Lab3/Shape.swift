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
    var color: UIColor
    var cachedPath: UIBezierPath?
    
    var center: CGPoint {
        didSet {
            // delete old path when center changed
            cachedPath = nil
        }
    }
    
    var size: CGFloat {
        didSet {
            // delete old path when size changed
            cachedPath = nil
        }
    }
    
    public required init(origin: CGPoint, color: UIColor){
        self.size = 50
        self.center = origin
        self.color = color
    }
    
    func draw() {
        fatalError("IMPLEMENT THIS")
    }
    
    func contains(point: CGPoint) -> Bool {
        fatalError("IMPLEMENT THIS")
    }
}
