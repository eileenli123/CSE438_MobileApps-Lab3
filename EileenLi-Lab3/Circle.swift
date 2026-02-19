//
//  Circle.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//
import UIKit

class Circle: Shape {


    required init(origin: CGPoint, color: UIColor) {
        //size is radius
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        
        if cachedPath == nil || cachedPath?.bounds.size.width != size || cachedPath?.bounds.origin != center {
            cachedPath = UIBezierPath(arcCenter: center, radius: size, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            
        }
        
 
        UIColor.black.setStroke()
        if let path = cachedPath {
            // fill
            color.setFill()
            path.fill()

            // outline
            UIColor.black.setStroke()
            path.stroke()
        }
    }
    
    override func contains(point: CGPoint) -> Bool {
        let distance = Functions.distance(a: center, b: point)
        return distance <= size
    }
}
