/*
 Interview Cake Problem 6
 
 Write a function to find the rectangular intersection of two given rectangles.
 
 */

struct Rectangle: CustomStringConvertible {
    // coordinates of bottom left corner
    let leftX: Int
    let bottomY: Int
    
    let width: Int
    let height: Int

    var description: String {
        return "\(leftX), \(bottomY), \(width), \(height)"
    }
}

extension Rectangle {
    func isUnder(_ r: Rectangle) -> Bool {
        return self.bottomY + self.height <= r.bottomY
    }
    
    func isAbove(_ r: Rectangle) -> Bool {
        return self.bottomY >= r.bottomY + r.height
    }
    
    func isToLeftOf(_ r: Rectangle) -> Bool {
        return self.leftX + self.width <= r.leftX
    }
    
    func isToRightOf(_ r: Rectangle) -> Bool {
        return self.leftX >= r.leftX + r.width
    }
    
    func overlapsWith(_ r: Rectangle) -> Bool {
        return !self.isUnder(r) || !self.isAbove(r) || !self.isToRightOf(r) || !self.isToLeftOf(r)
    }
    
    func isInside(_ r: Rectangle) -> Bool {
        return r.leftX <= self.leftX && (r.leftX + r.width) >= (self.leftX + self.width) &&
               r.bottomY <= self.bottomY && (r.bottomY + r.height) >= (self.bottomY + self.height)
    }
}

let r1 = Rectangle(leftX: 0, bottomY: 0, width: 1, height: 1)
let r2 = Rectangle(leftX: 1, bottomY: 0, width: 1, height: 1)

assert(r1.isToLeftOf(r2))
assert(!r1.isToRightOf(r2))
assert(!r1.isAbove(r2))
assert(!r1.isUnder(r2))

let r3 = Rectangle(leftX: 0, bottomY: 0, width: 2, height: 2)
assert(r1.overlapsWith(r3))

let r4 = Rectangle(leftX: 0, bottomY: 0, width: 3, height: 3)
let r5 = Rectangle(leftX: 1, bottomY: 1, width: 1, height: 1)
assert(r4.overlapsWith(r5))


// If Rectangles A and B overlap, this returns the overlapping Rectangle
// If they do not overlap, it returns nil

func getOverlap(of a: Rectangle, and b: Rectangle) -> Rectangle? {
    if !a.overlapsWith(b) {
        return nil
    } else if a.isInside(b) {
        return a
    } else if b.isInside(a) {
        return b
    }
    
    var leftX: Int
    var bottomY: Int
    var width: Int
    var height: Int
    
    switch (a.leftX <= b.leftX, a.bottomY <= b.bottomY) {
    case (true, true):
        leftX = b.leftX
        width = 2 * a.leftX + a.width - leftX
        bottomY = b.bottomY
        height = 2*a.bottomY + a.height - bottomY
    case (true, false):
        leftX = b.leftX
        width = 2 * a.leftX + a.width - leftX
        bottomY = a.bottomY
        height = 2*b.bottomY + b.height - bottomY
    case (false, true):
        leftX = a.leftX
        width = 2 * b.leftX + b.width - leftX
        bottomY = b.bottomY
        height = 2*a.bottomY + a.height - bottomY
    case (false, false):
        leftX = a.leftX
        width = 2 * b.leftX + b.width - leftX
        bottomY = a.bottomY
        height = 2*b.bottomY + b.height - bottomY
    }
    
    return Rectangle(leftX: leftX, bottomY: bottomY, width: width, height: height)
}

getOverlap(of: r1, and: r3)
getOverlap(of: r4, and: r5)
