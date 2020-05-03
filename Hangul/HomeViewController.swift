//
//  HomeViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 03/05/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum LanguageDirection {
        case koreanToEnglish
        case englishToKorean
    }
    
    private var languageState = LanguageDirection.englishToKorean {
        didSet {
            if languageState == .koreanToEnglish {
                languageSelectButton.setTitle("English → Korean", for: UIControl.State.normal)
            } else if languageState == .englishToKorean {
                languageSelectButton.setTitle("Korean → English", for: UIControl.State.normal)
            }
        }
    }
    
    @IBOutlet weak var languageSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        languageSelectButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func languageSelectButton(_ sender: UIButton) {
        if languageState == .koreanToEnglish {
            languageState = .englishToKorean
        } else if languageState == .englishToKorean {
            languageState = .koreanToEnglish
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var lettersToTest = [String:String]()
        var navTitle = "?"
        switch segue.identifier {
        case "Hangul Vowels Segue": lettersToTest = hangulVowels
            navTitle = "Vowels"
        case "Hangul Consonants Segue": lettersToTest = hangulConsonants
            navTitle = "Consonants"
        case "Hangul All Segue": lettersToTest = hangulConsonants
            lettersToTest.merge(dict: hangulVowels)
            navTitle = "All"
        default: break
        }
        if languageState == .koreanToEnglish {
            lettersToTest = reverse(dict: lettersToTest)
        }
        if let controller = segue.destination as? TestViewController {
            controller.test = Test(lettersToTest)
            controller.title = "가자! - " + navTitle
        }
    }
    
    private func reverse(dict : Dictionary<String, String>) -> Dictionary<String, String>{
        var newDict = [String:String]()
        for item in dict {
            newDict[item.value] = item.key
        }
        return newDict
    }

    private var hangulVowels = ["ㅏ":"a",
                                "ㅑ":"ya",
                                "ㅓ":"eo",
                                "ㅕ":"yeo",
                                "ㅗ":"o",
                                "ㅛ":"yo",
                                "ㅜ":"u",
                                "ㅠ":"yu",
                                "ㅡ":"eu",
                                "ㅣ":"i"]
    
    private var hangulConsonants = ["ㄱ":"g",
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
                                    "ㅎ":"h"]
    
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
