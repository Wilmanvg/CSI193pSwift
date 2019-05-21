//
//  ViewController.swift
//  Concentration
//
//  Created by Wilman Garcia on 5/15/19.
//  Copyright © 2019 Wilman Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards, numOfThemes: (emojiChoices.count))
    
//    var flipCount = 0 {
//        didSet {
//
//             flipCountLabel.text = "Flips: \(flipCount)"
//
//        }
//    }
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    //To show a return value -> Int etc
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    // var emojiChoices =  ["🎃","👻","🎃","👻"]
    
    @IBAction private func touchCard(_ sender: UIButton) {
        //flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    
    @IBAction private func touchNewGame(_ sender: UIButton) {
        
        for (_,emoj) in emoji{
            emojiChoices[game.themeKey]!.append(emoj)
        }
        
        emoji.removeAll()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2, numOfThemes: (emojiChoices.count))
        //game.chooseNewGame()
        updateViewFromModel()
        //flipCount = 0
        
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
   // var emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"]
    private var emojiChoices = [0: ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
                        1: ["⚾️","🎱","⚽️","🏀","🎾","🏈","🏐","🎳","🏑"],
                        2: ["🐊","🐆","🦗","🦓","🦖","🦕","🦒","🐄","🕊"],
                        3: ["👚","👘","👗","👖","👕","👔","🧥","🎽","👙"]
    ]

   // var emojiLib = [Int: [String]]()
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        //print("When grabbing face value theme is \(game.themeKey)")
        if emoji[card.identifier] == nil , emojiChoices[game.themeKey]!.count > 0 {
            let randomIndex = emojiChoices[game.themeKey]!.count.arc4random
            emoji[card.identifier] = emojiChoices[game.themeKey]!.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
