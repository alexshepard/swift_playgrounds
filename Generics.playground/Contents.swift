//: Generics

import UIKit

protocol Queue {
    typealias T
    func enqueue(item: T)
    func dequeue() -> T?
    func isEmpty() -> Bool
    func size() -> Int
}

class LLQueue<T>: Queue, CustomStringConvertible {
    
    // CustomStringConvertible
    var description: String {
        return "LLQueue [[ \(self.size()) ]]"
    }
    
    // Queue
    func enqueue(item: T) {
        // save the item at the end
        let oldLast = self.last
        self.last = Node(item: item, next: nil)
        if isEmpty() {
            first = self.last
        } else {
            oldLast!.next = self.last
        }
        N++
    }
    
    func dequeue() -> T? {
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
    
    var first: Node<T>?
    var last: Node<T>?
    
    // for size
    var N: Int = 0
}

// can't seem to nest generic classes
class Node<T> {
    var item: T
    var next: Node?
    
    init(item: T, next: Node?) {
        self.item = item
        self.next = next
    }
}

var strQueue = LLQueue<String>()
strQueue.enqueue("blah")

var intQueue = LLQueue<Int>()
intQueue.enqueue(1234)
intQueue.enqueue(19)
intQueue.dequeue()

var urlQueue = LLQueue<NSURL>()
if let url = NSURL(string: "http://www.meatfreezer.com") {
    urlQueue.enqueue(url)
}
if let url = NSURL(string: "http://www.inaturalist.org") {
    urlQueue.enqueue(url)
}
urlQueue.dequeue()
urlQueue.dequeue()


//: now let's try a generic array-backed stack
protocol Stack {
    typealias T
    func push(item: T)
    func pop() -> T?
    func isEmpty() -> Bool
    func size() -> Int
}

// simplest stack implementation, just want to see it in a generic
class ArrayStack<T>: Stack, CustomStringConvertible {
    // CustomStringConvertible
    var description: String {
        return "ArrayStack [[ \(self.size()) ]]"
    }
    
    func push(item: T) {
        // overflow not handled
        s[N++] = item
    }
    
    func pop() -> T? {
        // underflow not handled
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
    
    var s: [T?]
    var N: Int = 0
    
    init(capacity: Int) {
        s = [T?](count: capacity, repeatedValue: nil)
    }
}

let strings = "to be or not to - be - - that - - - is"
let components = strings.componentsSeparatedByString(" ")

var s = ArrayStack<String>(capacity: 10)

for str in components {
    
    s.size()
    
    if str == "-" {
        s.pop()
    } else {
        s.push(str)
    }
}


