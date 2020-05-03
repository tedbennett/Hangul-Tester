//
//  ViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 30/04/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var test = Test([String:String]())
    
    @IBAction func homeButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var mainLetterOutlet: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!

    @IBAction func touchUpLetter(_ sender: UIButton) {
        if test.checkLetterGuess(on: sender.titleLabel?.text ?? "?") {
            sender.backgroundColor = UIColor.systemGreen
        } else {
            sender.backgroundColor = UIColor.systemRed
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
            self.mainLetterOutlet.alpha = 0
            self.letterButtons.forEach{ $0.alpha = 0}
        }) { (_) in
            if self.test.isOver() {
                self.refreshView()
                UIView.animate(withDuration: 0.3, delay: 0.1, options: [], animations: {
                self.mainLetterOutlet.alpha = 1
                self.letterButtons.forEach{ $0.alpha = 1}
            }) { (_) in
                }
            } else {
                self.performSegue(withIdentifier: "Finish Test Segue", sender:sender)
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Finish Test Segue" {
            if let controller = segue.destination as? FinishTestViewController {
                controller.wrongLetters = self.test.wrongLetters
                controller.score = self.test.score
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for button in letterButtons {
            button.layer.cornerRadius = 12
        }
        navigationController?.navigationBar.isHidden = false
        refreshView()
    }
    
    
    private func refreshView() {
        let (topLetter, randomLetters) = test.getNextLetters()
        
        mainLetterOutlet.text = topLetter

        for (button, letter) in zip(letterButtons, randomLetters.shuffled()) {
            button.setTitle(letter, for: UIControl.State.normal)
            button.backgroundColor = UIColor.systemGray6
        }
    }
}


