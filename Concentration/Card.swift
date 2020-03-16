//
//  Card.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

struct Card: Hashable {
    private var identificator: Int
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    
    private static var lastGeneratedIdentificator = 0
    
    private static func getNewIdentificator() -> Int {
        lastGeneratedIdentificator += 1
        return lastGeneratedIdentificator
    }
    
    init() {
        identificator = Card.getNewIdentificator()
    }
    
    static func == (value1: Card, value2: Card) -> Bool {
        return value1.identificator == value2.identificator
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identificator)
    }
}
