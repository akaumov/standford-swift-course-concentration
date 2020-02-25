//
//  Card.swift
//  Concentration
//
//  Created by Azat Kaiumov on 23.02.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

struct Card {
    var identificator: Int
    var isFaceUp = false
    var isMatched = false
    
    static var lastGeneratedIdentificator = 0
    
    static func getNewIdentificator() -> Int {
        lastGeneratedIdentificator += 1
        return lastGeneratedIdentificator
    }
    
    init() {
        identificator = Card.getNewIdentificator()
    }
}
