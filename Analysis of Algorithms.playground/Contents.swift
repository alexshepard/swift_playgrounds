//: ## Week 1 - Analysis of Algorithms

import CoreFoundation

//: ### ThreeSum Protocol

protocol ThreeSum {
    static func count([Int]) -> Int
}

//: ### Test Data

//: ```makeList()``` - 
//: Helper function to make a list of random ints below 100
//: 
//: _this isn't terribly efficient, could re-use previously generated ints_

func makeList(count: Int) -> [Int] {
    var list = [Int]()
    for _ in 0..<count {
        list.append(Int(arc4random()) % 100)
    }
    return list
}

//: ```lists``` -
//: list of 10 lists of integers, doubling in size. 
//: 
//: _in the bruteforce implementation, this should produce a logRatio of 
//: running times that converges to 3, based on the efficiency (or lack 
//: thereof) of the bruteforce algorithm._

let lists: [[Int]] = {
    var lists = [[Int]]()
    for i in 1..<8 {
        let m = Int(pow(2.0, Double(i)))
        lists.append(makeList(m))
    }
    return lists
}()

//: ### Brute Force ThreeSum implementation

struct BruteForce: ThreeSum {
    static func count(a: [Int]) -> Int {
        var count = 0
        for i in 0..<a.count {
            for j in i+1..<a.count {
                for k in j+1..<a.count {
                    if (a[i]+a[j]+a[k] == 0) {
                        count++
                    }
                }
            }
        }
        return count
    }
}

//: ### Measure Brute Force ThreeSum implementation

//: _stash previous elapsed time so we can calculate the ratio of the current
//: elapsed time to the previous elapsed time._
var prevElapsed = 0.0

for list in lists {
    let start = CFAbsoluteTimeGetCurrent()
    BruteForce.count(list)
    // convert elapsed to millis
    let elapsed = (CFAbsoluteTimeGetCurrent() - start) * 1000
    if (prevElapsed > 0) {
        let ratio = elapsed / prevElapsed
        // doubling input size, should converge to 3
        let logRatio = log2(ratio)
    }
    prevElapsed = elapsed
}

//: ### Order of Growth Classifications

//: Binary Search

protocol BinarySearch {
    static func binarySearch(a: [Int], key: Int) -> Int
}

class FirstBinarySearch: BinarySearch {
    static func binarySearch(a: [Int], key: Int) -> Int {
        var lo = 0
        var hi = a.count - 1
        while lo <= hi {
            let mid = lo + (hi - lo) / 2
            if key < a[mid] {
                hi = mid - 1
            } else if key > a[mid] {
                lo = mid + 1
            } else {
                return mid
            }
        }
        return -1
    }
}

let a = [6,13,14,25,33,43,51,53,64,72,84,93,95,96,97]

var result = FirstBinarySearch.binarySearch(a, key: 34)





