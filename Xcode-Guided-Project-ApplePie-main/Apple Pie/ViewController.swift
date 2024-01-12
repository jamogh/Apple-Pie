//
//  ViewController.swift
//  Apple Pie
//
//  Created by Macbook Pro on 2020-12-12.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["aso", "pusa", "tae"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
                
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        let character = Character(letter.lowercased())
        currentGame.guessed(letter: character)
        updateGameState()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            updateUI()

            let alert = UIAlertController(title: "Game Over", message: scoreLabel.text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
    func updateGameState() {
        if(currentGame.incorrectMovesRemaining == 0) {
            totalLosses += 1
        } else if(currentGame.formattedWord == currentGame.word) {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    
    func updateUI() {
//        var letters = [String]()
//
//        for letter in currentGame.formattedWord {
//            letters.append(String(letter))
//        }
        
        let letters: [String] = currentGame.formattedWord.map{ String($0) }
        let guessedLetters = letters.joined(separator: " ")

        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        correctWordLabel.text = guessedLetters
        
    }
    
}

