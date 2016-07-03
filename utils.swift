// Contains useful functions 

import Foundation

func randomInt(lessThan n: UInt32) -> Int {
    return Int(arc4random_uniform(n))
}

func createRandomIntList(ofLength n: Int, withMax p: UInt32) -> [Int] {
    var x = [Int]()
    for _ in 0..<n {
        x.append(randomInt(lessThan: p))
    }
    return x
}
