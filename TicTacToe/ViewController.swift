//
//  ViewController.swift
//  TicTacToe
//
//  Created by Mason Bender on 2/23/18.
//  Copyright © 2018 Mason Bender. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    var gameOver = false
    
    // currentPlayer 1 = O, currentPlayer 2 = M
    var currentPlayer = 1
    
    // 0 = empty, 1 = O, 2 = M
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    let winningStates = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        var currentPosition = sender.tag - 1 // tags from 1-9, but array positions from 0-8. -1 adjusts accordingly
        
        // only allow a player to fill in a spot if it is empty
        if gameState[currentPosition] == 0 && !gameOver {
            gameState[currentPosition] = currentPlayer
            if currentPlayer == 1 {
                sender.setImage(UIImage(named: "O.jpg"), for: [])
                currentPlayer = 2
            } else {
                sender.setImage(UIImage(named: "M.png"), for: [])
                currentPlayer = 1
            }
            
            for state in winningStates {
                // must be either 1-1-1 or 2-2-2, so game isn't over yet
                if gameState[state[0]] != 0 && gameState[state[0]] == gameState[state[1]] && gameState[state[1]] == gameState[state[2]] {
                    
                    gameOver = true
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    
                    if gameState[state[0]] == 1 {
                        winnerLabel.text = "OSU Wins!"
                    } else {
                        winnerLabel.text = "UofM Wins :("
                    }
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                        self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                    })
                }
            }
            
        }
        
    }
    
    //on Play Again button being pressed, clear the board, hide the winner label and play again button, make game playable again
    @IBAction func playAgain(_ sender: Any) {
        winnerLabel.isHidden = true
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.isHidden = true
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
        
        gameState = [0,0,0,0,0,0,0,0,0]
        gameOver = false
        currentPlayer = 1
        
        // loop through all 9 spaces on board and set image to nil for each space based on their tag (1-9)
        for i in 1...9 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // hide the winner label and play again button when game starts
        winnerLabel.isHidden = true
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        
        playAgainButton.isHidden = true
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

