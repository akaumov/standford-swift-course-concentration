//
//  ViewController.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var themes = [
        ["🎃", "👻", "☠️", "💀", "👽", "🤖", "🤡", "👹", "👺", "👾"],
        ["🐶", "🐱", "🐭", "🐰", "🐹", "🦊", "🐻", "🐼", "🐨", "🐵"],
        ["🍎", "🍐", "🍌", "🍉", "🍋", "🍇", "🍓", "🥥", "🥝", "🍒"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓"],
        ["🚗", "🚑", "🚒", "🚅", "🚀", "🚓", "✈️", "⚓️", "🚜", "🛴"],
        ["⌚️", "📷", "💻", "⌨️", "🖥", "💿", "⏱", "⏰", "⏳", "☎️"]
    ]
    
    private var currentTheme: [String]?
    private var cardsEmoji = [Int:String]()
    private var numberOfPairsOfCards: Int {
        get {
            buttons.count/2
        }
    }
    
    private lazy var game = Concentration(numberOfCardsPair: numberOfPairsOfCards)

    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private var buttons: [UIButton]!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func clickButton(_ sender: UIButton, forEvent event: UIEvent) {
        if let cardIndex = buttons.firstIndex(of: sender) {
            game.chooseCard(cardIndex: cardIndex)
            updateViews()
        }
    }

    private func updateViews() {
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
        
        scoreLabel.text = "SCORE: \(game.score)"
    }
    
    
    private func emoji(identifier: Int) -> String {
        if currentTheme == nil {
            currentTheme = themes[Int.random(in: 0..<themes.count)]
        }
        
        if cardsEmoji[identifier] == nil {
            let emojiIndex = Int.random(in: 0..<currentTheme!.count)
            cardsEmoji[identifier] = currentTheme!.remove(at: Int(emojiIndex))
        }
        
        return cardsEmoji[identifier] ?? "?"
    }
    
    @IBAction private func clickStartNewGame(_ sender: UIButton) {
        game = Concentration(numberOfCardsPair: 10)
        currentTheme = nil
        updateViews()
    }
}

