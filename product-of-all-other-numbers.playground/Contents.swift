/*
 *** Interview Cake Problem 2
 You have a list of integers, and for each index you want to find the product of every integer except the integer at that index.
 
 
 Write a function get_products_of_all_ints_except_at_index() that takes a list of integers and returns a list of the products.
 
 https://www.interviewcake.com/question/python/product-of-other-numbers
 
 Do not use division
 
 Want the product of numbers before the specified index and the product of the numbers after the specified index
 */

func getProductsOfAllIntsExceptAtIndex(_ a: [Int]) -> [Int] {
    let n = a.count
    var products = [Int](repeating: 0, count: n)
    var productSoFar = 1
    
    // fwd pass, O(n)
    for i in 0..<n {
        products[i] = productSoFar
        productSoFar *= a[i]
    }
    
    // backwards pass, O(n)
    productSoFar = 1
    var i = n-1
    while i >= 0 {
        products[i] *= productSoFar
        productSoFar *= a[i]
        i -= 1
    }
    
    print(products)
    return products
}

getProductsOfAllIntsExceptAtIndex([1, 7, 3, 4]) == [84, 12, 28, 21]
