/** 
 Interview Cake problem 11
 **/

// Can use a set which stores a hash of the URL. But that will duplicate some info
struct Crawler {
    internal var urlsVisited = Set<Int>()
    
    func haveVisited(_ url: String) -> Bool {
        return urlsVisited.contains(url.hashValue)
    }
    
    mutating func storeUrl(_ url: String) {
        urlsVisited.insert(url.hashValue)
    }
}

// Using a trie is probably best, since during web crawling part of th URL would not change when crawling a site.

