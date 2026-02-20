//
//  Square.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//

import UIKit

class Square: Shape {

    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
    }
    
    override func draw() {
        // size or position changed --> recalculate path
        if cachedPath == nil || cachedPath?.bounds.size.width != size || cachedPath?.bounds.origin != center {
            let rect = CGRect(x: center.x - size, y: center.y - size, width: size*2, height: size*2)
            cachedPath = applyRotation(to: UIBezierPath(rect: rect))
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
        //define square bounds
        let minX = center.x - size / 2
        let maxX = center.x + size / 2
        let minY = center.y - size / 2
        let maxY = center.y + size / 2
        
        //check in bounds
        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }
}
