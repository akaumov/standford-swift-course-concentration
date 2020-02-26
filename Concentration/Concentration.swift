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
    
    init(numberOfCardsPair: Int) {
        cards = [Card]()
        
        for _ in 0..<numberOfCardsPair {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    func getIndexOfCardOpenedBefore() -> Int? {
        return cards.firstIndex(where: { item in !item.isMatched && item.isFaceUp })
    }
    
    func chooseCard(cardIndex: Int) {
        flipCount += 1
        
        let card = cards[cardIndex]
        let cardOpenedBeforeIndexOptional = getIndexOfCardOpenedBefore()
        let isFirstOpenedCard = cardOpenedBeforeIndexOptional == nil
        
        if isFirstOpenedCard  {
            cards[cardIndex].isFaceUp = true
            return
        }
        
        
        let cardOpenedBeforeIndex = cardOpenedBeforeIndexOptional!
        let cardOpenedBefore = cards[cardOpenedBeforeIndex]
        
        if cardOpenedBefore.identificator == card.identificator {
            cards[cardIndex].isFaceUp = true
            cards[cardIndex].isMatched = true
            cards[cardOpenedBeforeIndex].isMatched = true
            score += 1
            return
        }
        
        if card.isSeen {
            score -= 1
        }
        
        if cardOpenedBefore.isSeen {
            score -= 1
        }
        
        cards[cardOpenedBeforeIndex].isFaceUp = false
        cards[cardIndex].isFaceUp = true
    }
}
