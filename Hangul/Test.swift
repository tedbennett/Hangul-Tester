//
//  Test.swift
//  Hangul
//
//  Created by Ted Bennett on 03/05/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import Foundation


class Test {
    
    private lazy var orderedLetters = QueueArray<String>(elementArray: letters.keys.shuffled())
    
    private var letters = [String:String]()
    
    var wrongLetters = [String:String]()
    
    var score : Double {
        get {
            return 1.0 - (Double(wrongLetters.keys.count) / Double(letters.keys.count))
        }
    }
    
    private var currentTopLetter = String()
    
    init(_ letters: Dictionary<String, String>) {
        self.letters = letters
    }
    
    func checkLetterGuess(on letterGuess: String) -> Bool {
        if letters[currentTopLetter] == letterGuess {
            return true
        } else {
            wrongLetters[currentTopLetter] = letters[currentTopLetter]
            orderedLetters.enqueue(currentTopLetter)
            return false
        }
    }
    
    func getNextLetters() -> (topLetter: String, randomLetters: [String]) {
        currentTopLetter = orderedLetters.dequeue() ?? "?"
        
        var randomLetters = [String]()
        
        let randomSelection = letters.values.shuffled()[..<4]
        
        if randomSelection.contains(letters[currentTopLetter]!) {
            randomLetters.append(contentsOf: randomSelection)
        } else {
            randomLetters.append(contentsOf: randomSelection[..<3])
            randomLetters.append(letters[currentTopLetter]!)
        }
        return (topLetter: currentTopLetter, randomLetters: randomLetters)
    }
    
    func isOver() -> Bool {
        return orderedLetters.isEmpty
    }
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
