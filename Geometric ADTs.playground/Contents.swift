//: ## Geometric Abstract Data Types

import Foundation

protocol Point2D {
    init(x: Double, y: Double)
    var x: Double { get }           // x coordinate
    var y: Double { get }           // y coordinate
    var r: Double { get }           // radius (polar coordinates)
    var theta: Double { get }       // angle (polar coordinates)
    func distanceTo(that: Point2D) -> Double
    func draw()
}

protocol Interval1D {
    init(left: Double, right: Double)
    var left: Double { get }
    var right: Double { get }
    var length: Double { get }
    func contains(x: Double) -> Bool
    func intersects(that: Interval1D) -> Bool
}

protocol Interval2D {
    init(x: Interval1D, y: Interval1D)
    var area: Double { get }
    func contains(p: Point2D) -> Bool
    func intersects(that: Interval2D) -> Bool
    func draw()
}

struct APoint2D: Point2D {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    var r: Double {
        return 0.0
    }
    
    var theta: Double {
        return 0.0
    }
    
    func distanceTo(that: Point2D) -> Double {
        return sqrt(self.x * that.x + self.y + that.y)
    }
    
    func draw() {
        // do nothing yet
    }
}

