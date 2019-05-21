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
    var cards = [Card]()
    var chosenCards = [Int]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var themeKey: Int
    var flipCount = 0
    var score = 0
    
    
    func chooseCard(at index: Int) {
        
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
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int, numOfThemes: Int){
        
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
