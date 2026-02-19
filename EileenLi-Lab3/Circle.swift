//
//  Circle.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//
import UIKit

class Circle: Shape {
    var radius: CGFloat

    required init(origin: CGPoint, color: UIColor) {
        self.radius = 0
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        //Filled
//        color.setFill()
//        path.fill()
        
        UIColor.black.setStroke()
        path.stroke()
    }
    
    override func contains(point: CGPoint) -> Bool {
        let distance = Functions.distance(a: center, b: point)
        return distance <= radius
    }
}
