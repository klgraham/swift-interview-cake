/**
 * Given an array of integers, find the highestProduct you can get from three of the integers.
 The input a = [a_0, ..., a_{n-1}] will always have at least three integers.
 
 Can generate the n choose 3 combinations and compute the product of each one.
 
 Extend it to the highest product of four integers, then to k integers.
 
 Must be O(1) space and O(n) time
 */

struct MinMax: Equatable, CustomStringConvertible {
    var largest: Int
    var smallest: Int
    
    static func == (lhs: MinMax, rhs: MinMax) -> Bool {
        return lhs.largest == rhs.largest && lhs.smallest == rhs.smallest
    }
    
    mutating func update(_ a: Int) {
        largest = max(largest, a)
        smallest = min(smallest, a)
    }
    
    mutating func update(_ a: Int, _ b: Int) {
        largest = max(max(largest, a), b)
        smallest = min(min(smallest, a), b)
    }
    
    var description: String {
        return "MinMax(\(largest), \(smallest))"
    }
}

enum IllegalArgumentError: Error {
    case tooFewElementsInArray
}

func highestProduct(of tupleSize: Int, inList a: [Int]) throws -> Int {
    if a.count < tupleSize {
        throw IllegalArgumentError.tooFewElementsInArray
    }
    
    let n = a.count
    
    // initialize stats
    var statistics = [MinMax]()
    statistics.append(MinMax(largest: max(a[0], a[1]), smallest: min(a[0], a[1])))
    statistics.append(MinMax(largest: a[0] * a[1], smallest: a[0] * a[1]))
    
    var product = a[0] * a[1]
    
    for i in 2..<tupleSize {
        product *= a[i]
        statistics.append(MinMax(largest: product, smallest: product))
    }
    
    for i in (tupleSize - 2)..<n {
        let current = a[i]
        
        var j = tupleSize - 1
        while j > 0 {
            statistics[j].update(current * statistics[j - 1].largest, current * statistics[j - 1].smallest)
            j -= 1
        }
        statistics[0].update(current)
    }
    
    return statistics[tupleSize - 1].largest
}

print("Can compute the highest product of 3 ints: \(try highestProduct(of: 3, inList: [6, -10, 10, 4, -34]) == 3400)\n")
print("Can compute the highest product of 3 ints: \(try highestProduct(of: 3, inList: [-10, 10, 4, -34, 6]) == 3400)\n")

print("Can compute the highest product of 4 ints: \(try highestProduct(of: 4, inList: [-10, 10, 4, -34, 6, -35, 5]) == 71400)\n")
print("Can compute the highest product of 4 ints: \(try highestProduct(of: 4, inList: [-10, 10, 4, -34, 6, 5, -35, 5]) == 71400)\n")
print("Can compute the highest product of 4 ints: \(try highestProduct(of: 4, inList: [-34, -10, 10, 4, 6, 5, -35]) == 71400)\n")

print("Can compute the highest product of 5 ints: \(try highestProduct(of: 5, inList: [-35, -34, -10, 10, 4, 6, 5]) == 357000)\n")
print("Can compute the highest product of 5 ints: \(try highestProduct(of: 5, inList: [-10, 10, 4, -34, 6, 5, -35]) == 357000)\n")