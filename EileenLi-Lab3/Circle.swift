//
//  Circle.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//
import UIKit

class Circle: Shape {


    required override init(origin: CGPoint, color: UIColor, isFilled: Bool) {
        super.init(origin: origin, color: color, isFilled: isFilled)  // Call the superclass initializer
    }
    
    public required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        
        if cachedPath == nil || cachedPath?.bounds.size.width != size || cachedPath?.bounds.origin != center {
            cachedPath = UIBezierPath(arcCenter: center, radius: size, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            
        }
        
 
        if let path = cachedPath {
            
            if isFilled {
                // fill
                color.setFill()
                path.fill()
            } else {
                // outline
                color.setStroke()
                path.stroke()
            }
        }
    }
    
    override func contains(point: CGPoint) -> Bool {
        let distance = Functions.distance(a: center, b: point)
        return distance <= size
    }
}
