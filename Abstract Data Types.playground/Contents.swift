//: Playground - noun: a place where people can play

import UIKit


//: Counter protocol

protocol Counter: CustomStringConvertible {
    init(identifier: String)
    func tally() -> Int
    func increment()
}

class MyCounter: Counter {
    var count: Int = 0
    let identifier: String
    
    required init(identifier: String) {
        self.identifier = identifier
    }
    
    func tally() -> Int {
         return self.count
    }
    
    func increment() {
        count++
    }
    
    var description: String {
        return "\(identifier) counter - \(count)"
    }

}

let inc = 2

for i in 0..<12 {
    let total = Int(pow(Double(inc), Double(i)))
    let heads: Counter = MyCounter(identifier: "Heads")
    let tails: Counter = MyCounter(identifier: "Tails")
    for j in 0..<total {
        if (arc4random() % 2 == 0) {
            tails.increment()
        } else {
            heads.increment()
        }
    }
    
    // variance is asymptotic to zero as inputs grow
    // is that the correct use of asymptotic?
    let variance = Double(abs(heads.tally() - tails.tally())) / Double(total)
}





