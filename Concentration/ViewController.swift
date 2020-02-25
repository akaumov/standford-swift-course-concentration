//
//  ViewController.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var emojiChoices = ["🎃", "👻", "💀", "☠️", "👠", "🐨", "🧤", "👺", "🤡", "🤓", "👜", "👁", "👀"]
    var cardsEmoji = [Int:String]()
    
    lazy var game = Concentration(numberOfCardsPair: 10)

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func clickButton(_ sender: UIButton, forEvent event: UIEvent) {
        if let cardIndex = buttons.firstIndex(of: sender) {
            game.chooseCard(cardIndex: cardIndex)
            updateViews()
        }
    }

    func updateViews() {
        for (index, card) in game.cards.enumerated() {
            var button = buttons[index]
            
            if card.isMatched {
                button.setTitle(emoji(identifier: card.identificator), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1004120291)
            } else if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(emoji(identifier: card.identificator), for: UIControl.State.normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5145950317, blue: 0, alpha: 1)
                button.setTitle( "", for: UIControl.State.normal)
            }
        }
        
        newGameButton.isHidden = !game.isCompleted
        scoreLabel.text = "Score: \(game.score)"
    }
    
    
    func emoji(identifier: Int) -> String {
        if cardsEmoji[identifier] == nil {
            let emojiIndex = Int.random(in: 0..<emojiChoices.count)
            cardsEmoji[identifier] = emojiChoices.remove(at: Int(emojiIndex))
        }
        
        return cardsEmoji[identifier] ?? "?"
    }
    
    @IBAction func clickStartNewGame(_ sender: UIButton) {
        game = Concentration(numberOfCardsPair: 10)
        updateViews()
    }
    
    override func viewDidLoad() {

    }
}

