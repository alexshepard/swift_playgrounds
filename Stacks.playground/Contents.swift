//: ### modular data types -
//: completely separate the interface from the implementation.

import Foundation

//: non-generics
protocol StackOfStrings {
    func push(item: String)
    func pop() -> String
    func isEmpty() -> Bool
    func size() -> Int
}

class LLStackOfStrings: StackOfStrings, CustomStringConvertible {
    
    // CustomStringConvertible
    var description: String {
        return "LLStackOfStrings [[ \(self.size()) ]]"
    }
    
    // StackOfStrings
    func push(item: String) {
        let oldFirst = self.first
        let newFirst = StringNode(item: item, next: oldFirst)
        self.first = newFirst
        self.N++
    }
    
    func pop() -> String {
        if let top = self.first {
            self.first = top.next
            N--
            return top.item
        } else {
            return ""
        }
    }
    
    func isEmpty() -> Bool {
        return first == nil
    }
    
    func size() -> Int {
        return N
    }
    
    // Linked List Plumbing

    private
    
    var first: StringNode?
    var N: Int = 0
    
    // seems to need to be a class instead of a struct
    // in order to have an optional next
    class StringNode {
        var item: String = ""
        var next: StringNode?
        
        init(item: String, next: StringNode?) {
            self.item = item
            self.next = next
        }
    }
}


//: client

let strings = "to be or not to - be - - that - - - is"
let components = strings.componentsSeparatedByString(" ")

var s: StackOfStrings = LLStackOfStrings()
for str in components {
    if str == "-" {
        s.pop()
    } else {
        s.push(str)
    }
}
s
