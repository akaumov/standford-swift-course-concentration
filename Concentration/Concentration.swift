//
//  Concentration.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards: [Card] {
        didSet {
            isCompleted = cards.allSatisfy({$0.isMatched})
        }
    }
    
    private(set) var flipCount: Int = 0
    private(set) var score: Int = 0
    var isCompleted = false
    
    init(numberOfCardsPair: Int) {
        guard numberOfCardsPair > 0 else {
            fatalError("Concentration.init(numberOfCardsPair: \(numberOfCardsPair). You must have at least one pair of cards")
        }
        
        cards = [Card]()
        
        for _ in 0..<numberOfCardsPair {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    mutating func chooseCard(cardIndex: Int) {
        guard cards.indices.contains(cardIndex) else {
            fatalError("Concentration.chooseCard(at: \(cardIndex). Chosen index not in the cards")
        }
        defer { cards[cardIndex].isFaceUp = true }
        
        let cardOpenedBeforeIndex = cards.firstIndex(where: { card in card.isFaceUp && !card.isMatched})
        if cardOpenedBeforeIndex == cardIndex {
            return
        }
        
        flipCount += 1
        
        if cardOpenedBeforeIndex == nil {
            return
        }
        
        let cardOpenedBefore = cards[cardOpenedBeforeIndex!]
        
        if cardOpenedBefore == cards[cardIndex] {
            cards[cardIndex].isMatched = true
            cards[cardOpenedBeforeIndex!].isMatched = true
            score += 2
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
    }
}
