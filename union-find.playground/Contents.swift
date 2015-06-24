//: Week 1 - Union Find

//: Dynamic Connectivity
protocol UnionFind {
    init(n: Int)
    
    func union(p: Int, q: Int)
    func connected(p: Int, q: Int) -> Bool
    
    func find(p: Int) -> Int
    func count() -> Int
}

//: Quick Find Implementation
class QuickFind: UnionFind, CustomStringConvertible {
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

//: Quick-union (lazy approach)
class QuickUnion1: UnionFind, CustomStringConvertible {
    var id: [Int]
    
    required init(n: Int) {
        id = [Int]()
        for i in 0..<n {
            id.append(i)
        }
    }
    
    // helper to find the root of a node
    func root(p:Int) -> Int {
        var i = p
        while i != id[i] {
            i = id[i]
        }
        return i
        
        /* or recursively
        if id[p] == p {
            return p
        } else {
            return root(id[p])
        }
        */
    }
    
    func union(p: Int, q: Int) {
        id[root(p)] = id[root(q)]
    }
    
    func connected(p: Int, q: Int) -> Bool {
        return root(id[p]) == root(id[q])
    }
    
    func find(p: Int) -> Int {
        return id[p]
    }
    
    func count() -> Int {
        return id.count
    }
    
    // customStringConvertible
    var description: String {
        return "QuickUnion1: \(self.id)"
    }
}

//: Quick-union (lazy) demo
var qu = QuickUnion1(n: 10)
qu.union(4, q: 3)
qu.union(3, q: 8)
qu.union(6, q: 5)
qu.union(9, q: 4)
qu.union(2, q: 1)
qu.connected(8, q: 9)
qu.connected(5, q: 0)
qu.union(5, q: 0)
qu.union(7, q: 2)
qu.union(6, q: 1)
qu.union(7, q: 3)
