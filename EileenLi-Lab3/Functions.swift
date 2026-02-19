//
//  Functions.swift
//  EileenLi-Lab3
//
//  Created by Eileen Li on 2/19/26.
//

import Foundation
import UIKit

class Functions {
    static func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt(pow(a.x - b.x,2) + pow(a.y - b.y,2))
        
    }
}
