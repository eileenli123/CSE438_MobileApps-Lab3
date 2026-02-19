//
//  Triangle.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//

import Foundation
import UIKit

class Triangle: Shape {
    
    required init(origin: CGPoint, color: UIColor) {
        //size is edge length
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        // size or position changed --> recalculate path
        if cachedPath == nil || cachedPath?.bounds.size.width != size || cachedPath?.bounds.origin != center {
            
            let path = UIBezierPath()
            let xAxis = center.x
            let yAxis = center.y
            let width = size * 2    // base (same as diameter of circle)
            let height = width * 0.866    // equilateral height is approx 0.866 of base

            path.move(to: CGPoint(x: xAxis - width / 2, y: yAxis + height / 2))  // Left
            path.addLine(to: CGPoint(x: xAxis + width / 2, y: yAxis + height / 2))  // Right
            path.addLine(to: CGPoint(x: xAxis, y: yAxis - height / 2))  // Top
            path.close()
            
            cachedPath = path
        }
        
        // Use the cached path for drawing
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
        // Check if the point is inside the box bounding square
        let minX = center.x - size
        let maxX = center.x + size
        let minY = center.y - size
        let maxY = center.y + size
        
        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }
}
