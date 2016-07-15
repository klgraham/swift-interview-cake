import Foundation

let unshuffledDeck = (0..<52).map { $0 }
let half1 = unshuffledDeck.filter { $0 < 52/2 }
let half2 = unshuffledDeck.filter { $0 >= 52/2 }

// an integer on [0, max]
func randomInt(max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max + 1)))
}

func riffleShuffle(deck1: [Int], deck2: [Int]) -> [Int] {
    var shuffledDeck = [Int]()
    var deck1Copy = deck1
    var deck2Copy = deck2
    
    while (!deck1Copy.isEmpty || !deck2Copy.isEmpty) {
        if !deck1Copy.isEmpty {
            let cardsFromDeck1 = randomInt(max: deck1Copy.count)
            for _ in 0..<cardsFromDeck1 {
                let card = deck1Copy.remove(at: 0)
                shuffledDeck.append(card)
            }
        }
        
        if !deck2Copy.isEmpty {
            let cardsFromDeck2 = randomInt(max: deck2Copy.count)
            for _ in 0..<cardsFromDeck2 {
                let card = deck2Copy.remove(at: 0)
                shuffledDeck.append(card)
            }
        }
    }
    
    return shuffledDeck
}

/* 
 Let's define what it means for a deck to be riffled.
 
 First, riffling results in sequences of consecutive cards from a single deck, followed by
 a sequences of consecutive cards from the other deck. The boundary between sequences from
 the two decks will be called a domain wall. We can look at the the average distance 
 between domain walls or the average domain size to see if we have a riffled deck. 
 Here is a criterions: average domain wall distance > 3
 
 The two statistics amount to t
 */

func deckIsRiffled(_ deck: [Int], domainSeparatationThreshold: Double = 3.0) -> Bool {
    var domainWallLocations = [Int]() // first domain wall is at the head of the list
    
    var deckCopy = deck
    var previousCard = deckCopy.removeFirst()
    domainWallLocations.append(previousCard)
    var domainWallSeparationsSum = 0
    var previousLocation = 0
    
    for (index, card) in deckCopy.enumerated() {
        if (card - previousCard) > 1  {
            domainWallLocations.append(index)
            domainWallSeparationsSum += index - previousLocation
            previousLocation = index
        }
        previousCard = card
        
    }
    
    if domainWallLocations.count == 1 {
        return false
    } else {
        let avgDomainWallSeparation = Double(domainWallSeparationsSum) / Double(domainWallLocations.count - 1)
//        print("Average domain wall separation = \(avgDomainWallSeparation)")
        return avgDomainWallSeparation >= domainSeparatationThreshold
    }
}

var riffledDeckCount = 0
let N = 100
for _ in 0...N {
    let riffledDeck = riffleShuffle(deck1: half1, deck2: half2)
    let isRiffled = deckIsRiffled(riffledDeck, domainSeparatationThreshold: 2.0)
    if isRiffled {
        riffledDeckCount += 1
    } else {
        print("Unriffled deck: \(riffledDeck)")
    }
}
let ratioOfRiffledDecks = Double(riffledDeckCount) / Double(N)
print("Ratio of Riffled Decks: \(ratioOfRiffledDecks)")
deckIsRiffled(unshuffledDeck)