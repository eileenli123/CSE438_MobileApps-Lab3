//
//  SolidShape.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/21/26.
//

import Foundation
import UIKit

class SolidShape: Shape {
    public required init(origin: CGPoint, color: UIColor){
        super.init(origin: origin, color: color)
    }
    
    public override init(origin: CGPoint, color: UIColor, shape: ShapeType){
        super.init(origin: origin, color: color, shape: shape)
    }
    
    override func draw() {
        if cachedPath == nil || cachedPath?.bounds.size.width != size || cachedPath?.bounds.origin != center {
            cachedPath = getShapePath()
        }
        
        // Use the cached path for drawing
        if let path = cachedPath {
            color.setFill()
            path.fill()
        }
    }
    
}

