//
//  ResultsTableViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 03/05/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var items = [IncorrectGuess]()
    
    func populateTable(with itemDictionary : Dictionary<String, String>) {
        for item in itemDictionary {
            items.append(IncorrectGuess(item.key, item.value))
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "letterCell", for: indexPath) as! LetterViewCell
        
        cell.koreanLetterLabel.text = items[indexPath.row].koreanLetter
        cell.englishLetterLabel.text = items[indexPath.row].englishLetter
        
        return cell
    }


}

struct IncorrectGuess {
    var koreanLetter = ""
    var englishLetter = ""
    
    
    init(_ koreanLetter : String, _ englishLetter : String) {
        self.koreanLetter = koreanLetter
        self.englishLetter = englishLetter
    }
}
