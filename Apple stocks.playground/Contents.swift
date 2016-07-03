/*
 *** Interview Cake, problem 1 ***
 
 Suppose we could access yesterday's stock prices as a list, where:
 
 The indices are the time in minutes past trade opening time, which was 9:30am local time.
 The values are the price in dollars of Apple stock at that time.
 So if the stock cost $500 at 10:30am, stock_prices_yesterday[60] = 500.
 
 Write an efficient function that takes stock_prices_yesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.
 
 test on [10, 7, 5, 8, 11, 9], answer should be 6
 
 Need a function that goes through the list and finds all ordered pairs (m,n) such that index of m < index of n, only keeping the pair with the largest (n-m) 
 */

func computeMaxProfit(stockPrices: [Int]) -> Int {
    var low = Int.max
    var high = Int.min
    
    for price in stockPrices {
        if price < low {
            low = price
        } else if price > high {
            high = price
        }
    }
    return high - low
}

let testPrices = [10, 7, 5, 8, 11, 9]
assert(computeMaxProfit(stockPrices: testPrices) == 6)