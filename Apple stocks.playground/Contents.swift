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


func computeMaxProfit(stockPrices: [Int]) -> Int {
    if stockPrices.isEmpty {
        return 0
    }
    
    var lowestPrice = stockPrices[0]
    var bestProfit = 0
    
    for price in stockPrices {
        if price < lowestPrice {
            lowestPrice = price
        }
        let possibleProfit = price - lowestPrice
        if possibleProfit > bestProfit {
            bestProfit = possibleProfit
        }
    }
    return bestProfit
}

assert(computeMaxProfit(stockPrices: [10, 7, 5, 8, 11, 9]) == 6)

assert(computeMaxProfit(stockPrices: [10, 7, 5, 8, 11, 9, 3, 2, 1]) == 6)
