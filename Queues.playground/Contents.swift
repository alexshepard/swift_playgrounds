

import UIKit

// not generic yet
protocol QueueOfStrings {
    func enqueue(item: String)
    func dequeue() -> String?
    func isEmpty() -> Bool
    func size() -> Int
}

class LLQueueOfStrings: QueueOfStrings, CustomStringConvertible {
    
    // CustomStringConvertible
    var description: String {
        return "LLQueueOfStrings [[ \(self.size()) ]]"
    }
    
    // QueueOfStrings
    func enqueue(item: String) {
        // save the item at the end
        let oldLast = self.last
        self.last = StringNode(item: item, next: nil)
        if isEmpty() {
            first = self.last
        } else {
            oldLast!.next = self.last
        }
        N++
    }
    
    func dequeue() -> String? {
        let item = self.first!.item
        first = first!.next
        if isEmpty() {
            last = nil
        }
        N--
        return item
    }
    
    func isEmpty() -> Bool {
        return self.first == nil
    }
    
    func size() -> Int {
        return N
    }

    // Linked List Plumbing
    
    private
    
    var first: StringNode?
    var last: StringNode?
    // for size
    var N: Int = 0

    class StringNode {
        var item: String = String()
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

var s: QueueOfStrings = LLQueueOfStrings()
s.enqueue("one")
s
s.enqueue("two")
s
s.dequeue()
s.dequeue()
s

for str in components {
    s.size()
    if str == "-" {
        s.dequeue()
    } else {
        s.enqueue(str)
    }
}


