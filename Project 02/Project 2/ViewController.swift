//
//  ViewController.swift
//  Project2
//
//  Created by Roberts Kursitis on 22/03/2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    
    var bestScore = Int()
    var scoreArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(scoreArray, forKey: "highscores")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Highscore", style: .plain, target: self, action: #selector(scoreButton))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.systemGray.cgColor
        button2.layer.borderColor = UIColor.systemGray.cgColor
        button3.layer.borderColor = UIColor.systemGray.cgColor
        askQuestion(action: nil)
    }
    
    @objc func scoreButton() {
        let highscore = scoreArray.sorted { $0 > $1 }
        let ac = UIAlertController(title: "Highscore", message: "Current highscore is: \(highscore[0])", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        bestScore = highscore[0]
        print("current HS: \(highscore[0])")
        print("full array \(highscore)")
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased() + " Score: \(score), Guesses: \(count)"
        view.transform = .identity
        scoreArray.append(bestScore)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
//            self.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) })
//
        var title: String
    
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            bestScore += 1
//        } else if sender.tag != correctAnswer && sender.tag == 0 {
//            title = "Incorrect, that's the flag of \(countries[0])"
//            score -= 1
//        } else if sender.tag != correctAnswer && sender.tag == 1 {
//            title = "Incorrect, that's the flag of \(countries[1])"
//            score -= 1
//        } else if sender.tag != correctAnswer && sender.tag == 2 {
//            title = "Incorrect, that's the flag of \(countries[2])"
//            score -= 1
        } else {
            switch sender.tag {
                case 0:
                    title = "Incorrect, that's the flag of \(countries[0])"
                    score = 0
                    
                case 1:
                    title = "Incorrect, that's the flag of \(countries[1])"
                    score = 0
                case 2:
                    title = "Incorrect, that's the flag of \(countries[2])"
                    score = 0
                default:
                    title = "something went wrong"
                    score -= 420
            }
            bestScore = 0
        }
        if count == 3 {
            let ac = UIAlertController(title: title, message: "You've gussed \(count) times!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue?", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations:  {
                    sender.transform = CGAffineTransform.identity
                })
            })
        //works but presents the same time a different AlertController does :(
        
//        if score > scoreArray[0] {
//            let ac = UIAlertController(title: "New Highscore!", message: "You've achieved a new highscore of \(score)", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
//            present(ac, animated: true)
//         }
        count += 1
        scoreArray.append(bestScore)
    }
}
