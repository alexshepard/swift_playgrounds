//: ## Week 1 - Analysis of Algorithms
//: Warning - this playground stresses the hell out of Xcode

import CoreFoundation

//: ### ThreeSum Protocol
//: Given a list of integers, count the number of sets of three
//: in the list that add up to zero.
protocol ThreeSum {
    static func count([Int]) -> Int
}

//: ### Test Data Generators
//: ```makeList()``` - 
//: Helper function to make a list of random ints below 100. 
//: Every other int will be negative.
//: 
//: _this isn't terribly efficient, could re-use previously generated ints_
func makeList(count: Int) -> [Int] {
    var list = [Int]()
    for i in 0..<count {
        let sign = (i % 2 == 0) ? -1 : 1
        list.append(sign * Int(arc4random()) % 100)
    }
    return list
}

//: ```lists``` -
//: list of ```n-1``` lists of integers, doubling in size.
func listOfLists(n: Int) -> [[Int]] {
    let lists: [[Int]] = {
        var lists = [[Int]]()
        for i in 1..<n {
            let m = Int(pow(2.0, Double(i)))
            lists.append(makeList(m))
        }
        return lists
        }()
    return lists
}

//: ### Test Routine
//: Watch the lines beginning with ```let elapsed``` or ```logRatio = ``` 
//: to see how the algorithm is performing.
func measure(n: Int, threeSum: (list: [Int]) -> Int) -> Double {
    let lols = listOfLists(n)
    
    var prevElapsed = 0.0
    
    var logRatio: Double = 0.0
    for list in lols {
        let start = CFAbsoluteTimeGetCurrent()
        threeSum(list: list)
        let elapsed = CFAbsoluteTimeGetCurrent() - start
        if (prevElapsed > 0) {
            let ratio = elapsed / prevElapsed
            logRatio = log2(ratio)
        }
        prevElapsed = elapsed
    }
    return logRatio
}

//: ### Brute Force ThreeSum implementation
//: Works, but slows drastically as input grows. The three array
//: access inside triple nested loops make this algorithm execution
//: time grow cubicly as input doubles.
struct BruteForce: ThreeSum {
    static func count(a: [Int]) -> Int {
        let aLen = a.count
        var count = 0
        for i in 0..<aLen {
            for j in i+1..<aLen {
                for k in j+1..<aLen {
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
//: This implementation should produce a logRatio of increasing running
//: times with doubled input size converging on 3, or cubic growth. 
//: this implementation starts to converge for me when n is 8 or above.
let bruteForceLogRatio = measure(9, threeSum: BruteForce.count)

//: ### Binary Search Helper
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

//: ### Sort-based ThreeSum implementation
//: This algorithm improves on the brute force implementation because
//: two array accesses plus a binary search inside of double nested
//: loops is fewer operations than three array accesses inside triple
//: nested loops.
//: Note: _using our custom FirstBinarySearch is considerably slower
//: than using the swift array indexOf() method, at least in part due to
//: the Playground's instrumentation of FirstBinarySearch._
struct SortBased: ThreeSum {
    static func count(a: [Int]) -> Int {
        let sorted = a.sort()   // haven't done our own sort yet. this is swift2 syntax.
        let sortedLen = sorted.count
        var count = 0
        
        for i in 0..<sortedLen {
            for j in i+1..<sortedLen {
                let key = -sorted[i] - sorted[j]
                
                //let result = FirstBinarySearch.binarySearch(sorted, key: key)
                //if result > j {
                //    count++
                //}
                
                if let index = sorted.indexOf(key) where index > j {
                    count++
                }
            }
        }
        
        return count
    }
}

//: ### Measure Sort-based ThreeSum implementation
//: This implementation should produce a logRatio of increasing running
//: times with doubled input size converging just over 2, or N^2lgN
//: growth. this implementation starts to converge for me right away, with
//: a visible pattern forming when n is around 7.
let sortBasedLogRatio = measure(7, threeSum: SortBased.count)



