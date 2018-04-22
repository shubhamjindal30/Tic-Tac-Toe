//
//  PlayViewController.swift
//  Tic Tac Toe
//
//  Created by Shubham Jindal on 12/04/18.
//  Copyright © 2018 sjc. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var player1Name: UITextField!
    @IBOutlet weak var player2Name: UITextField!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Variables to play the music
    var musicPlayer: MusicPlayer = MusicPlayer(PlayList())
    var filterBySinger = "All"
    var muteImage = #imageLiteral(resourceName: "Mute")
    var volumeImage = #imageLiteral(resourceName: "Volume")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the textField delegates
        player1Name.delegate = self
        player2Name.delegate = self
        
        //Dismiss the keyboard on touching anywhere else
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Method to end editing the keyboard when user clicks on return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Method to end editing when the user taps anywhere else
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Setting the names if the textFields are not empty
        if player1Name.text != "" && player1Name.text != " " {
            appDelegate.Player1Label = player1Name.text!
        }
        if player2Name.text != "" && player2Name.text != " " {
            appDelegate.Player2Label = player2Name.text!
        }
    }

    //Action for playing or stopping the music
    @IBAction func playOrStopAction(_ sender: UIButton) {
        if sender.imageView?.image == muteImage {
            sender.setImage(volumeImage, for: .normal)
            musicPlayer.play(filterBy: filterBySinger)
        } else if sender.imageView?.image == volumeImage {
            sender.setImage(muteImage, for: .normal)
            musicPlayer.stop()
        }
    }
    
    //Action to change the difficulty level
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        switch sender.selectedSegmentIndex {
        case 0: appDelegate.difficulty = "Easy"
            break
        case 1: appDelegate.difficulty = "Hard"
            break
        default: break
        }
    }
    
}
