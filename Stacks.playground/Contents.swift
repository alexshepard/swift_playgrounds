//: ### modular data types -
//: completely separate the interface from the implementation.

import Foundation

//: non-generics
protocol StackOfStrings {
    func push(item: String)
    func pop() -> String?
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
    
    func pop() -> String? {
        if let top = self.first {
            self.first = top.next
            N--
            return top.item
        } else {
            return nil
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

class ArrayStackOfStrings: StackOfStrings, CustomStringConvertible {
    // CustomStringConvertible
    var description: String {
        return "ArrayStackOfStrings [[ \(self.size()) ]]"
    }
    
    func push(item: String) {
        
        s[N++] = item
    }
    
    func pop() -> String? {
        return s[--N]
    }
    
    func isEmpty() -> Bool {
        return N == 0
    }
    
    func size() -> Int {
        return N
    }
    
    // Array Plumbing
    // this is a swift array, but we won't use cheaty swift methods on it
    
    private

    var s: [String] = [String]()
    var N: Int = 0
    
    init(capacity: Int) {
        // this doesn't feel ideal, but you can't index into an array in swift
        // until it's had something appended index
        for _ in 0...capacity {
            s.append(String())
        }
    }
    
}

class SwiftArrayStackOfStrings: StackOfStrings, CustomStringConvertible {
    
    // CustomStringConvertible
    var description: String {
        return "SwiftArrayStackOfStrings [[ \(self.size()) ]]"
    }
    
    func push(item: String) {
        // cheating with swift
        s.append(item)
    }
    
    func pop() -> String? {
        if (s.count > 0) {
            // cheating with swift
            return s.removeLast()
        } else {
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        return s.count == 0
    }
    
    func size() -> Int {
        return s.count
    }
    
    // Swift Array Plumbing
    
    var s: [String] = [String]()
}

//: client

let strings = "to be or not to - be - - that - - - is"
let components = strings.componentsSeparatedByString(" ")

var s: StackOfStrings = ArrayStackOfStrings(capacity: 10)
for str in components {
    if str == "-" {
        s.pop()
    } else {
        s.push(str)
    }
}
s


