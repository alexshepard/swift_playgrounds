//: Week 1 - Union Find

//: Dynamic Connectivity
protocol UF {
    init(n: Int)
    
    func union(p: Int, q: Int)
    func connected(p: Int, q: Int) -> Bool
    
    func find(p: Int) -> Int
    func count() -> Int
}

//: Quick Find Implementation
class QuickFind: UF, CustomStringConvertible {
    var id: [Int]
    
    required init(n: Int) {
        self.id = [Int]()
        for i in 0..<n {
            self.id.append(i)
        }
    }
    
    func union(p: Int, q: Int) {
        let pid = self.id[p]
        let qid = self.id[q]        
        for i in 0..<self.id.count {
            if self.id[i] == pid {
                self.id[i] = qid
            }
        }
    }
    
    func connected(p: Int, q: Int) -> Bool {
        return self.id[p] == self.id[q]
    }
    
    func find(p: Int) -> Int {
        return self.id[p]
    }
    
    func count() -> Int {
        return self.id.count
    }
    
    // CustomStringConvertible
    var description: String {
        return "QuickFind \(self.id)"
    }
    
}

//: QuickFind Demo
var qf = QuickFind(n: 10)
qf.union(4, q: 3)
qf.union(3, q: 8)
qf.union(6, q: 5)
qf.union(9, q: 4)
qf.union(2, q: 1)
qf.connected(8, q: 9)
qf.connected(5, q: 0)
qf.union(5, q: 0)
qf.union(7, q: 2)
qf.union(6, q: 1)



