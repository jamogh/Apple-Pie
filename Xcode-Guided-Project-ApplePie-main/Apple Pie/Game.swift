//
//  Game.swift
//  Apple Pie
//
//  Created by Macbook Pro on 2020-12-12.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        
        var formattedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                formattedWord += "\(letter)"
            } else {
                formattedWord += "_"
            }
        }
        
        return formattedWord
    }
    
    mutating func guessed(letter: Character) {
        guessedLetters.append(letter)
        
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
