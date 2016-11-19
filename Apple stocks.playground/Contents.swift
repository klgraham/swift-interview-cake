/*
 *** Interview Cake, problem 1 ***
 
 Suppose we could access yesterday's stock prices as a list, where:
 
 The indices are the time in minutes past trade opening time, which was 9:30am local time.
 The values are the price in dollars of Apple stock at that time.
 So if the stock cost $500 at 10:30am, stock_prices_yesterday[60] = 500.
 
 Write an efficient function that takes stock_prices_yesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.
 
 test on [10, 7, 5, 8, 11, 9], answer should be 6
 If I test on [10, 7, 5, 8, 11, 9, 3, 2, 1], the answer should still be 6
 */

enum StockPriceError: Error {
    case notEnoughStocksToComparePrices
}
func computeMaxProfit(stockPricesYesterday: [Int]) throws -> Int {
    if stockPricesYesterday.count < 2 {
        throw StockPriceError.notEnoughStocksToComparePrices
    }
    
    var lowestPrice = stockPricesYesterday[0]
    var bestProfit = stockPricesYesterday[1] - stockPricesYesterday[0]
    
    for price in stockPricesYesterday {
        let possibleProfit = price - lowestPrice
        
        lowestPrice = min(price, lowestPrice)
        bestProfit = max(possibleProfit, bestProfit)
    }
    return bestProfit
}

print("Can compute correct best profit: \(try computeMaxProfit(stockPricesYesterday: [10, 7, 5, 8, 11, 9]) == 6)\n")

print("Can compute correct best profit: \(try computeMaxProfit(stockPricesYesterday: [10, 7, 5, 8, 11, 9, 3, 2, 1]) == 6)\n")

print("If prices always go down, best profit is negative: \(try computeMaxProfit(stockPricesYesterday: [34, 30, 25, 23, 20, 17, 15, 12, 8, 6, 4, 2, 1]) >= 0)\n")

print("If prices don't change, best profit is 0: \(try computeMaxProfit(stockPricesYesterday: [3, 3, 3, 3, 3, 3]) == 0)\n")

// Need at least two prices
let singlePrice = try? computeMaxProfit(stockPricesYesterday: [3])

if singlePrice == nil {
    print("Can't compute best price from [3], need at least two prices for comparison")
}