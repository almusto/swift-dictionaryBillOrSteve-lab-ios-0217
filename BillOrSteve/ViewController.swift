//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Create your stored properties here

  var billAndSteveFacts: [String : [String]] = [:]
  var correctPerson: String = ""
  var score : Int = 0

  @IBOutlet weak var factLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var steveButton: UIButton!
  @IBOutlet weak var billButton: UIButton!
  @IBOutlet weak var correctLabel: UILabel!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var playAgainButon: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createFacts()
        showFact()
        correctLabel.isHidden = true
        nextButton.isHidden = true
        playAgainButon.isHidden = true
    }
    
    
    
    
    
    // Helper Functions
  func createFacts() {
    let steveFacts = [
      "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
      "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
      "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
      "He was a pescetarian, meaning he ate no meat except for fish."
    ]

    let billFacts = [
      "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
      "He scored 1590 (out of 1600) on his SATs.",
      "His foundation spends more on global health each year than the United Nation's World Health Organization.",
      "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
      "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
    ]


    billAndSteveFacts["Bill Gates"] = billFacts
    billAndSteveFacts["Steve Jobs"] = steveFacts

  }

  func checkIfEmpty() {
    var person = randomPerson()
    if person == "Steve Jobs" && billAndSteveFacts[person]!.count == 0 {
      person = "Bill Gates"
    } else if person == "Bill Gates" && billAndSteveFacts[person]!.count == 0 {
      person = "Steve Jobs"
    }
    correctPerson = person

  }

  func getRandomFact() -> (String) {
      checkIfEmpty()
      var index : Int = 0
      var fact = String()

    if billAndSteveFacts["Bill Gates"]!.count == 0 && billAndSteveFacts["Steve Jobs"]!.count == 0 {
      fact = "Game Over"
      steveButton.isEnabled = false
      billButton.isEnabled = false
      playAgainButon.isHidden = false
    } else {
      if let array = billAndSteveFacts[correctPerson] {
        index = randomIndex(fromArray: array)
        fact = array[index]
      }
          billAndSteveFacts[correctPerson]?.remove(at: index)
    }


      return fact

  }


  func showFact() {

    factLabel.text = getRandomFact()

  }

  @IBAction func stevePressed(_ sender: Any) {
    let string = "Steve Jobs"
    correctLabel.isHidden = false
    nextButton.isHidden = false
    if (string == correctPerson) {
      correctLabel.text = "Correct!"
      score += 1
      scoreLabel.text = String(score)
    } else {
      correctLabel.text = "Nope!"
    }
  }

  @IBAction func billPressed(_ sender: Any) {
    let string = "Bill Gates"
    correctLabel.isHidden = false
    nextButton.isHidden = false
    if (string == correctPerson) {
      correctLabel.text = "Correct!"
      score += 1
      scoreLabel.text = String(score)
    } else {
      correctLabel.text = "Nope!"
    }
  }
  @IBAction func nextPressed(_ sender: Any) {
    showFact()
    correctLabel.isHidden = true
    nextButton.isHidden = true
  }
  @IBAction func playAgainPressed(_ sender: Any) {
    createFacts()
    showFact()
    playAgainButon.isHidden = true
    score = 0
    scoreLabel.text = String(score)
    billButton.isEnabled = true
    steveButton.isEnabled = true
    correctLabel.isHidden = true
    nextButton.isHidden = true
  }

    func randomIndex(fromArray array: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(array.count)-1))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
}
