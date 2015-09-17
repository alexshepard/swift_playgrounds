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
        // need to handle overflow
        s[N++] = item
    }
    
    func pop() -> String? {
        // need to handle underflow
        // loitering here: we're done with this str, but we're leaving it in the array
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

    var s: [String]
    var N: Int = 0
    
    init(capacity: Int) {
        s = [String](count: capacity, repeatedValue: String())
    }
}

class ResizingArrayStackOfStrings: StackOfStrings, CustomStringConvertible {
    // CustomStringConvertible
    var description: String {
        return "ResizingArrayStackOfStrings [[ \(self.size()) ]]"
    }
    
    func push(item: String) {
        if N == s.count {
            resize(2 * s.count)
        }
        s[N++] = item
    }
    
    func pop() -> String? {
        // still loitering
        return s[--N]
    }
    
    func isEmpty() -> Bool {
        return N == 0
    }
    
    func size() -> Int {
        return N
    }
    
    private func resize(capacity: Int) {
        for _ in s.count...capacity {
            s.append(String())
        }
    }
    
    // Array Plumbing
    // this is a swift array, but we won't use cheaty swift methods on it
    
    private
    
    var s: [String]
    var N: Int = 0
    
    init() {
        // start with a single element array
        s = [String](count: 1, repeatedValue: String())
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

var s: StackOfStrings = ResizingArrayStackOfStrings()
for str in components {
    if str == "-" {
        s.pop()
    } else {
        s.push(str)
    }
}

