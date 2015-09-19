//: Iterators, or in swift, Sequences

import UIKit

// forcing implementations of Queue to be sequence-able
protocol Queue: SequenceType {
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
    
    func generate() -> AnyGenerator<T> {
        var n:Node? = self.first
        return anyGenerator {
            let this: Node? = n
            n = n?.next
            return this?.item
        }
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

var urlQueue = LLQueue<NSURL>()
if let url = NSURL(string: "http://www.meatfreezer.com") {
    urlQueue.enqueue(url)
}
if let url = NSURL(string: "http://www.inaturalist.org") {
    urlQueue.enqueue(url)
}


for url in urlQueue {
    print("url is \(url)")
}


