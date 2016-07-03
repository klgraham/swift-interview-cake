/*
 *** Interview Cake Problem 2
 You have a list of integers, and for each index you want to find the product of every integer except the integer at that index.
 
 
 Write a function get_products_of_all_ints_except_at_index() that takes a list of integers and returns a list of the products.
 
 https://www.interviewcake.com/question/python/product-of-other-numbers
 
 Do not use division
 
 Want the product of numbers before the specified index and the product of the numbers after the specified index
 */

func productOfElements(in list: [Int], until stop: Int) -> Int {
    var prod = 1
    var index = 0
    
    while index < stop {
        prod *= list[index]
        index += 1
    }
    return prod
}

func getProductsOfAllIntsExceptAtIndex(_ list: [Int]) -> [Int] {
    let reversedList: [Int] = list.reversed()
    let N = list.count
    var productList = [Int]()
    
    for i in 0..<N {
        let reversedIndex = N - 1 - i
        let before = productOfElements(in: list, until: i)
        let after = productOfElements(in: reversedList, until: reversedIndex)
        productList.append(before * after)
    }
    
    return productList
}

getProductsOfAllIntsExceptAtIndex([1, 7, 3, 4]) == [84, 12, 28, 21]
