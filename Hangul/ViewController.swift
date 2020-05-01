//
//  ViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 30/04/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topSymbolOutlet: UILabel!

    @IBAction func touchSymbol(_ sender: UIButton) {
        if let topSymbol = topSymbolOutlet.text {
            if hangulSymbols[topSymbol] == sender.titleLabel?.text {
                sender.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        }

    }
    
    
    @IBOutlet var symbolButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshSymbols()
    }
    
    private func refreshSymbols() {
        let randomSymbols = hangulSymbols.shuffled()[..<4]
        print(randomSymbols)
        topSymbolOutlet.text = randomSymbols[0].key
        var index = 0
        for button in symbolButtons.shuffled() {
            button.setTitle(randomSymbols[index].value, for: UIControl.State.normal)
            index += 1
        }
   
    }
    
    private var hangulSymbols = ["ㄱ":"g",
                                 "ㄴ":"n",
                                 "ㄷ":"d",
                                 "ㄹ":"l/r",
                                 "ㅁ":"m",
                                 "ㅂ":"b",
                                 "ㅅ":"s",
                                 "ㅇ":"ng",
                                 "ㅈ":"j",
                                 "ㅊ":"ch",
                                 "ㅋ":"k",
                                 "ㅌ":"t",
                                 "ㅍ":"p",
                                 "ㅎ":"h",
                                 "ㅏ":"a",
                                 "ㅑ":"ya",
                                 "ㅓ":"eo",
                                 "ㅕ":"yeo",
                                 "ㅗ":"o",
                                 "ㅛ":"yo",
                                 "ㅜ":"u",
                                 "ㅠ":"yu",
                                 "ㅡ":"eu",
                                 "ㅣ":"i"]
    private var chosenSymbols = [String]()
}

