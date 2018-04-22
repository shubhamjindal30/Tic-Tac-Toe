//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Shubham Jindal on 06/04/18.
//  Copyright © 2018 sjc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var multiplayerSwitch: UISwitch!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var crossNoughtSwitch: UISwitch!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var player1SwitchLabel: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    var black: UIColor = .black
    var red: UIColor = .red
    
    //Variable for appDelegate to use the shared variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var player1Name: String = "Player 1"
    var player2Name: String = "Player 2"
    
    //Variables for scores of players
    var score1 = 0
    var score2 = 0
    
    //Grid for game
    var matrix = [
        [0 ,0 ,0 ,0],
        [0 ,0 ,0 ,0],
        [0 ,0 ,0 ,0],
        [0 ,0 ,0 ,0]
    ]
    
    //Image variables to add in the history
    var player1: UIImage = #imageLiteral(resourceName: "Cross")
    var player2: UIImage = #imageLiteral(resourceName: "Nought")
    
    //Variables to play the game
    var row = 0
    var col = 0
    var winner = 0
    var activePlayer = 1

    override func viewWillAppear(_ animated: Bool) {
        if appDelegate.Player1Label != "" && appDelegate.Player1Label != " " {
            player1Name = appDelegate.Player1Label
        }
        if appDelegate.Player2Label != "" && appDelegate.Player2Label != " " {
            player2Name = appDelegate.Player2Label
        }
        
        //Setting the names of players
        player1Label.text = player1Name + ":"
        player1SwitchLabel.text = player1Name + ":"
        player2Label.text = player2Name + ":"
        
        //Change the lebel text on the start of the game
        turnLabel.text = "\(player1Name)'s turn"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method to find the winner
    func findWinner() -> Int {
        var winner = 0
        var flag = 0
        
        for i in 0...3 {
            for j in 0...3 {
                if matrix[i][j] == 0 {
                    flag = 1
                }
            }
        }
        if matrix[0][0] != 0 &&
            matrix[0][0] == matrix[0][1] &&
            matrix[0][1] == matrix[0][2] &&
            matrix[0][2] == matrix[0][3] {
            winner = matrix[0][0]
        } else if matrix[1][0] != 0 &&
            matrix[1][0] == matrix[1][1] &&
            matrix[1][1] == matrix[1][2] &&
            matrix[1][2] == matrix[1][3] {
            winner = matrix[1][0]
        } else if matrix[2][0] != 0 &&
            matrix[2][0] == matrix[2][1] &&
            matrix[2][1] == matrix[2][2] &&
            matrix[2][2] == matrix[2][3] {
            winner = matrix[2][0]
        } else if matrix[3][0] != 0 &&
            matrix[3][0] == matrix[3][1] &&
            matrix[3][1] == matrix[3][2] &&
            matrix[3][2] == matrix[3][3] {
            winner = matrix[3][0]
        } else if matrix[0][0] != 0 &&
            matrix[0][0] == matrix[1][0] &&
            matrix[1][0] == matrix[2][0] &&
            matrix[2][0] == matrix[3][0] {
            winner = matrix[0][0]
        } else if matrix[0][1] != 0 &&
            matrix[0][1] == matrix[1][1] &&
            matrix[1][1] == matrix[2][1] &&
            matrix[2][1] == matrix[3][1] {
            winner = matrix[0][1]
        } else if matrix[0][2] != 0 &&
            matrix[0][2] == matrix[1][2] &&
            matrix[1][2] == matrix[2][2] &&
            matrix[2][2] == matrix[3][2] {
            winner = matrix[0][2]
        } else if matrix[0][3] != 0 &&
            matrix[0][3] == matrix[1][3] &&
            matrix[1][3] == matrix[2][3] &&
            matrix[2][3] == matrix[3][3] {
            winner = matrix[0][3]
        } else if matrix[0][0] != 0 &&
            matrix[0][0] == matrix[1][1] &&
            matrix[1][1] == matrix[2][2] &&
            matrix[2][2] == matrix[3][3] {
            winner = matrix[0][0]
        } else if matrix[0][3] != 0 &&
            matrix[0][3] == matrix[1][2] &&
            matrix[1][2] == matrix[2][1] &&
            matrix[2][1] == matrix[3][0] {
            winner = matrix[0][3]
        } else if flag == 0 {
            winner = -1
        } else {
            winner = 0
        }
        return winner
    }
    
    //Method to reset the game
    func resetGame() {
        for i in 0...15 {
            buttons[i].setImage(nil, for: .normal)
        }
        for i in 0...3 {
            for j in 0...3 {
                matrix[i][j] = 0
            }
        }
        activePlayer = 1
        if player1 == #imageLiteral(resourceName: "Cross") {
            turnLabel.textColor = red
        } else if player1 == #imageLiteral(resourceName: "Nought") {
            turnLabel.textColor = black
        }
        turnLabel.text = "\(player1Name)'s turn"
    }
    
    //Method to display the result i.e winner or draw
    func displayResult() {
        if winner != 0 {
            if winner == -1 {
                //If the game is a draw
                let alert = UIAlertController(title: "Game Over!", message: "It's a Draw.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                //Append the result in hisory
                appDelegate.winnings.append("Draw")
                appDelegate.images.append(nil)
                
                //Check the mode of game i.e 1P or 2P
                if multiplayerSwitch.isOn {
                    appDelegate.mode.append("\(player1Name) vs \(player2Name)")
                } else {
                    appDelegate.mode.append("\(player1Name) vs Computer(\(appDelegate.difficulty))")
                }
            } else {
                if multiplayerSwitch.isOn {
                    //If the game is in 2P mode
                    if winner == 1 {
                    let alert = UIAlertController(title: "Game Over!", message: "\(player1Name) wins",    preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        appDelegate.winnings.append("\(player1Name)")
                    } else {
                        let alert = UIAlertController(title: "Game Over!", message: "\(player2Name) wins",    preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        appDelegate.winnings.append("\(player2Name)")
                    }
                    appDelegate.mode.append("\(player1Name) vs \(player2Name)")
                } else {
                    //If the game is in 1P mode
                    appDelegate.mode.append("\(player1Name) vs Computer(\(appDelegate.difficulty))")
                    if winner == 1 {
                        appDelegate.winnings.append("\(player1Name)")
                        let alert = UIAlertController(title: "Game Over!", message: "\(player1Name) wins",    preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        appDelegate.winnings.append("Computer")
                        let alert = UIAlertController(title: "Game Over!", message: "Computer wins",    preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                //Update the score in local scoreboard
                if winner == 1 {
                    appDelegate.images.append(player1)
                    score1 += 1
                    player1Score.text = "\(score1)"
                }
                else {
                    appDelegate.images.append(player2)
                    score2 += 1
                    player2Score.text = "\(score2)"
                }
            }
            //Reset the game after finishing
            resetGame()
        }
    }

    //Action to play the game
    @IBAction func tapAction(_ sender: UIButton) {
        row = sender.tag / 4
        col = sender.tag % 4
        if matrix[row][col] == 0 {
            if activePlayer == 1 {
                sender.setImage(player1, for: .normal)
                if multiplayerSwitch.isOn {
                    if player2 == #imageLiteral(resourceName: "Cross") {
                        turnLabel.textColor = red
                    } else if player2 == #imageLiteral(resourceName: "Nought") {
                        turnLabel.textColor = black
                    }
                    turnLabel.text = "\(player2Name)'s turn"
                }
            } else if activePlayer == 2 && multiplayerSwitch.isOn {
                sender.setImage(player2, for: .normal)
                if player2 == #imageLiteral(resourceName: "Cross") {
                    turnLabel.textColor = black
                } else if player2 == #imageLiteral(resourceName: "Nought") {
                    turnLabel.textColor = red
                }
                turnLabel.text = "\(player1Name)'s turn"
            }
            matrix[row][col] = activePlayer
            activePlayer = (activePlayer % 2) + 1
        }
        
        winner = findWinner()
        
        if winner != 0 {
            //Create a pause before displaying the alert
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.displayResult()
            }
        }
        
        
        //If the game is in 1P mode, the computer will play it's move
        if !multiplayerSwitch.isOn && winner != 1 {
            var row = 0
            var col = 0
            var firstEmpty: Bool = true
            var flag = 0
            for i in 0...3 {
                for j in 0...3 {
                    //Logic to play turn on the spot where computer will win
                    if matrix[i][j] == 0 {
                        matrix[i][j] = 2
                        winner = findWinner()
                        if firstEmpty {
                            row = i
                            col = j
                            firstEmpty = false
                        }
                        if winner == 2 {
                            flag = 1
                            buttons[i * 4 + j].setImage(player2, for: .normal)
                            
                            //Create a pause before the alert is displayed
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                self.displayResult()
                            }
                            return
                        } else {
                            matrix[i][j] = 0
                        }
                        
                        //Logic for the difficult level, in this the computer will never let the user win
                        if appDelegate.difficulty == "Hard" {
                            matrix[i][j] = 1
                            winner = findWinner()
                            if winner == 1 {
                                matrix[i][j] = 2
                                activePlayer = 1
                                
                                //Create a pause before the computer plays its turn
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    self.buttons[i * 4 + j].setImage(self.player2, for: .normal)
                                }
                                winner = findWinner()
                                
                                //If the game is draw
                                if winner == -1 {
                                    
                                    //Create a pause before the alert is displayed
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        self.displayResult()
                                    }
                                }
                                return
                            } else {
                                matrix[i][j] = 0
                            }
                        }
                    }
                }
            }
            
            //If no one is winning, computer will play on the first spot available on the board
            if flag == 0 {
                matrix[row][col] = 2
                
                //Create a pause
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.buttons[row * 4 + col].setImage(self.player2, for: .normal)
                    self.displayResult()
                }
                activePlayer = 1
            }
        }
    }
    
    //Action to back to the home screen
    @IBAction func homeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Action to change the symbol
    @IBAction func CrossNoughtValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            player1 = #imageLiteral(resourceName: "Cross")
            player2 = #imageLiteral(resourceName: "Nought")
        } else {
            
            player1 = #imageLiteral(resourceName: "Nought")
            player2 = #imageLiteral(resourceName: "Cross")
        }
        resetGame()
    }
    
    //Action to change the mode of the game
    @IBAction func MultiplayerSwitchAction(_ sender: UISwitch) {
        resetGame()
        if sender.isOn {
            player2Label.text = "\(player2Name):"
        } else {
            player2Label.text = "Computer:"
        }
        score1 = 0
        score2 = 0
        player1Score.text = "\(score1)"
        player2Score.text = "\(score2)"
    }
    
    //Action to reset the game
    @IBAction func resetGame(_ sender: UIButton) {
        resetGame()
    }
}

