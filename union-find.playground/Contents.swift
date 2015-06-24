//: Week 1 - Union Find

//: Dynamic Connectivity
protocol UF {
    init(n: Int)
    
    func union(p: Int, q: Int)
    func connected(p: Int, q: Int) -> Bool
    
    func find(p: Int) -> Int
    func count() -> Int
}


