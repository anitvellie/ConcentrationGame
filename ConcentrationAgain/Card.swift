//
//  Card.swift
//  ConcentrationAgain
//
//  Created by Alevtina on 27/02/2019.
//  Copyright © 2019 Alevtina. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    
}
