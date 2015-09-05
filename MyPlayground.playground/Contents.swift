//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let numbers = Array(0..<10)
numbers
let oddCubes = numbers.map({ $0 * $0 * $0 })
                      .filter({ $0 % 2 != 0 })
oddCubes

let view = UIView()
let otherView = UIView()

let constraint1 = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: otherView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
let constraint2 = view.centerXAnchor.constraintEqualToAnchor(otherView.centerXAnchor)


//numbers.map({ pow(Double($0), 3.0) })

//numbers.map({ pow($0, 3) })

//let numbers = [1, 5, 6, 10, 16, 42, 45]
//(0..<100).map { pow($0, 3) }
//let evenCubes = 0..<100.map { $0 * 3 }.filter { $0 % 2 == 0 }
//evenCubes
//find(filter(map(numbers, { $0 * 2}), { $0 % 3 == 0 }), 90)
//numbers.map { $0 * 2 }.filter { $0 % 3 == 0 }.indexOf(90) // returns 2

