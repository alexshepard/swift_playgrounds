//: Week 1 - Union Find

//: Dynamic Connectivity
protocol UnionFind: CustomStringConvertible {
    init(n: Int)
    
    func union(p: Int, q: Int)
    func connected(p: Int, q: Int) -> Bool
    
    func find(p: Int) -> Int
    func count() -> Int
    
}

var pairs:[(p: Int, q: Int)] = []
pairs.append((p: 4, q: 3))
pairs.append((p: 3, q: 8))
pairs.append((p: 6, q: 5))
pairs.append((p: 9, q: 4))
pairs.append((p: 3, q: 8))
pairs.append((p: 6, q: 5))
pairs.append((p: 9, q: 4))
pairs.append((p: 2, q: 1))

var uf: UnionFind

//: Quick Find Implementation
class QuickFind: UnionFind {
    var id: [Int]
    
    required init(n: Int) {
        id = [Int]()
        for i in 0..<n {
            id.append(i)
        }
    }
    
    func union(p: Int, q: Int) {
        let pid = id[p]
        let qid = id[q]
        for i in 0..<id.count {
            if id[i] == pid {
                id[i] = qid
            }
        }
    }
    
    func connected(p: Int, q: Int) -> Bool {
        return id[p] == id[q]
    }
    
    func find(p: Int) -> Int {
        return id[p]
    }
    
    func count() -> Int {
        return id.count
    }
    
    // CustomStringConvertible
    var description: String {
        return "QuickFind: \(id)"
    }
    
}

//: QuickFind Demo
uf = QuickFind(n: 10)
for (p, q) in pairs {
    uf.union(p, q: q)
    uf.description
}
uf.connected(8, q: 9)
uf.connected(5, q: 0)

//: Quick-union (lazy approach)
class LazyQuickUnion: UnionFind {
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
        return "LazyQuickUnion: \(self.id)"
    }
}

//: Quick-union (lazy) demo
uf = LazyQuickUnion(n: 10)
for (p, q) in pairs {
    uf.union(p, q: q)
    uf.description
}
uf.connected(8, q: 9)
uf.connected(5, q: 0)



//: Quick-union (weighted with path compression)
class WeightedQuickUnion: LazyQuickUnion {
    var sz: [Int]
    
    override func root(p: Int) -> Int {
        var i = p
        while i != id[i] {
            // path compression
            id[i] = id[id[i]]
            i = id[i]
        }
        return i
    }
    
    override func union(p: Int, q: Int) {
        
        let i = root(p)
        let j = root(q)
        
        if i == j {
            return
        }
        
        if sz[i] < sz[j] {
            id[i] = j
            sz[j] += sz[i]
        } else {
            id[j] = i
            sz[i] += sz[j]
        }
    }
    
    required init(n: Int) {
        sz = [Int]()
        for _ in 0..<n {
            sz.append(1)
        }
        super.init(n: n)
    }
    
    override var description: String {
        return "WeightedQuickUnion: \(id)"
    }
}

//: Quick-union (weighted) demo
uf = WeightedQuickUnion(n: 10)
for (p, q) in pairs {
    uf.union(p, q: q)
    uf.description
}
uf.connected(8, q: 9)
uf.connected(5, q: 0)





