//
//  ViewController.swift
//  ConcentrationAgain
//
//  Created by Alevtina on 21/02/2019.
//  Copyright © 2019 Alevtina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var numberOfPairOfCards: Int {
        return ((cardButtons.count + 1) / 2)
    }
    
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)

    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips count: \(flipCount)"
        }
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons.")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emoji = Dictionary<Int, String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }
    }
    
    private var emojiChoices = ["🦇", "🍭", "🙀", "👹", "👻", "🎃", "🔮", "🍎", "🕸"]
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

