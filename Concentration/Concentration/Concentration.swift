//
//  Concentration.swift
//  Concentration
//
//  Created by Wilman Garcia on 5/16/19.
//  Copyright © 2019 Wilman Garcia. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    private(set) var chosenCards = [Int]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                        
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set {
            
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    var themeKey: Int
    var flipCount = 0
    var score = 0
    
    
    func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.ChooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    
                    if chosenCards.contains(cards[index].identifier) || chosenCards.contains(cards[matchIndex].identifier){
                        score -= 1
                    } else {
                        chosenCards.append(cards[index].identifier)
                        chosenCards.append(cards[matchIndex].identifier)
                    }
                }
                cards[index].isFaceUp = true
                //indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, numOfThemes: Int){
        
        assert(numberOfPairsOfCards > 0, "Concentration.ChooseCard(at: \(numberOfPairsOfCards)): not possible to have  < 0 cards")
        Card.identifierFactory = 0
        themeKey = Int(arc4random_uniform(UInt32(numOfThemes)))
        //print("Theme key is \(themeKey)")
        
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        chosenCards.removeAll()
    }
}
