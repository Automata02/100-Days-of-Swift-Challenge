//
//  GameViewController.swift
//  Project29
//
//  Created by Roberts Kursitis on 11/07/2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var currentGame: GameScene?

    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    
    var player1score: Int = 0 {
        didSet {
            player1ScoreLabel.text = "Score: \(player1score)"
        }
    }
    var player2score: Int = 0 {
        didSet {
            player2ScoreLabel.text = "Score: \(player2score)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1score = 0
        player2score = 0
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        AngleChanged(self)
        velocityChanged(self)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func AngleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(velocitySlider.value.rounded(.up))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    func playerScored(player: Int) {
        if player == 1 {
            player1score += 1
        }
        else {
            player2score += 1
        }

        if player1score == 3 {
            playerNumber.text = "PLAYER 1 WINS"
            angleSlider.isHidden = true
            angleLabel.isHidden = true
            velocitySlider.isHidden = true
            velocityLabel.isHidden = true
            launchButton.isHidden = true
        }
        else if player2score == 3 {
            playerNumber.text = "PLAYER 2 WINS"
            angleSlider.isHidden = true
            angleLabel.isHidden = true
            velocitySlider.isHidden = true
            velocityLabel.isHidden = true
            launchButton.isHidden = true
        }
    }
}
