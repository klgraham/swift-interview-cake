/*
 *** Interview Cake Problem 2
 You have a list of integers, and for each index you want to find the product of every integer except the integer at that index.
 
 
 Write a function get_products_of_all_ints_except_at_index() that takes a list of integers and returns a list of the products.
 
 https://www.interviewcake.com/question/python/product-of-other-numbers
 
 Do not use division
 
 Want the product of numbers before the specified index and the product of the numbers after the specified index
 */

func arrayProd(_ x: [Int]) -> Int {
    return x.reduce(1, combine: *)
}

func elementsBefore(index: Int, inList: [Int]) -> [Int] {
    var elementsBefore = [Int]()
    
    for i in 0..<inList.count {
        if i < index {
            elementsBefore.append(inList[i])
        }
    }
    return elementsBefore
}

func elementsAfter(index: Int, inList: [Int]) -> [Int] {
    var elementsAfter = [Int]()
    
    for i in 0..<inList.count {
        if i > index {
            elementsAfter.append(inList[i])
        }
    }
    return elementsAfter
}

// I tried implementing the for loop using array.map, but that showed that map does not 
// iterate through the list in order
func getProductsOfAllIntsExceptAtIndex(_ list: [Int]) -> [Int] {
    
    if list.isEmpty {
        return [Int]()
    } else {
        var result = [Int]()
        for i in 0..<list.count {
            result.append(arrayProd(elementsBefore(index: i, inList: list)) * arrayProd(elementsAfter(index: i, inList: list)))
        }
        return result
    }
}

getProductsOfAllIntsExceptAtIndex([1, 7, 3, 4]) == [84, 12, 28, 21]
