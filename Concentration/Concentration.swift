//
//  Concentration.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

class Concentration {
    var cards: [Card] {
        didSet {
            isCompleted = cards.allSatisfy({$0.isMatched})
        }
    }
    
    var flipCount: Int = 0
    var score: Int = 0
    var isCompleted = false
    var cardOpenedBeforeIndex: Int?
    
    init(numberOfCardsPair: Int) {
        cards = [Card]()
        
        for _ in 0..<numberOfCardsPair {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    func chooseCard(cardIndex: Int) {
        
        cards[cardIndex].isFaceUp = true
        flipCount += 1
        
        if cardOpenedBeforeIndex == nil {
            cardOpenedBeforeIndex = cardIndex
            return
        }
        
        let cardOpenedBefore = cards[cardOpenedBeforeIndex!]
        
        if cardOpenedBefore.identificator == cards[cardIndex].identificator {
            cards[cardIndex].isMatched = true
            cards[cardOpenedBeforeIndex!].isMatched = true
            score += 2
            cardOpenedBeforeIndex = nil
            return
        }
        
        if cards[cardIndex].isSeen {
            score -= 1
        }
        
        if cardOpenedBefore.isSeen {
            score -= 1
        }
        
        cards[cardOpenedBeforeIndex!].isFaceUp = false
        cards[cardOpenedBeforeIndex!].isSeen = true
        cardOpenedBeforeIndex = cardIndex
    }
}
