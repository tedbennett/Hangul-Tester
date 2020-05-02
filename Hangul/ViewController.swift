//
//  ViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 30/04/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLetterOutlet: UILabel!

    @IBAction func touchUpLetter(_ sender: UIButton) {
        if let topLetter = mainLetterOutlet.text {
            if hangulLetters[topLetter] == sender.titleLabel?.text {
                sender.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                letterKeys.enqueue(topLetter)
            }
        }
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
            self.view.alpha = 0
        }) { (_) in
            if !self.letterKeys.isEmpty {
                self.refreshSymbols()
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.view.alpha = 1
            }) { (_) in
                }
            } else {
                print("You win!")
            }
        }

    }
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for button in letterButtons {
            button.layer.cornerRadius = 12
        }

        refreshSymbols()
    }
    
    private func refreshSymbols() {
        let topLetter = letterKeys.dequeue() ?? "?"
        
        var randomLetters = [String]()
        
        let randomSelection = hangulLetters.keys.shuffled()[..<4]
        
        if randomSelection.contains(topLetter) {
            randomLetters.append(contentsOf: randomSelection)
        } else {
            randomLetters.append(contentsOf: randomSelection[..<3])
            randomLetters.append(topLetter)
        }
        
        print(randomLetters)
        mainLetterOutlet.text = topLetter

        for (button, letterKey) in zip(letterButtons, randomLetters.shuffled()) {
            button.setTitle(hangulLetters[letterKey], for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
   
    }
    
    lazy private var letterKeys = QueueArray<String>(elementArray: hangulLetters.keys.shuffled())
    
    private var hangulLetters = ["ㄱ":"g",
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
    private var chosenLetters = [String]()
}


protocol Queue {
    
    associatedtype Element
    
    //enqueue：add an object to the end of the Queue
    mutating func enqueue(_ element: Element)
    //dequeue：delete the object at the beginning of the Queue
    mutating func dequeue() -> Element?
    //isEmpty：check if the Queue is nil
    var isEmpty: Bool { get }
    //peek：return the object at the beginning of the Queue without removing it
    var peek: Element? { get }
    
}

struct QueueArray<T>: Queue {
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        return array.isEmpty ? nil : array.removeFirst()
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var peek: T? {
        return array.first
    }
    
    func shuffled() -> [T] {
        return array.shuffled()
    }
    
    typealias Element = T
    
    private var array: [T]
    
    init(elementArray: [Element]) {
        array = elementArray
    }
}
