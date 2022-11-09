//
//  GameScene.swift
//  Project11
//
//  Created by Roberts Kursitis on 20/04/2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballLimit = 5 {
        didSet {
            ballCountLabel.text = "\(ballLimit) balls remaining"
        }
    }
    var ballCountLabel: SKLabelNode!
    var randomBall: Int = 0
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text  = "Edit"
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 650)
        addChild(scoreLabel)
        
        ballCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballCountLabel.horizontalAlignmentMode = .right
        ballCountLabel.text = "5 balls remaining"
        ballCountLabel.position = CGPoint(x: 980, y: 600)
        addChild(ballCountLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 650)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 45), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 45), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 45), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 45), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 35))
        makeBouncer(at: CGPoint(x: 256, y: 35))
        makeBouncer(at: CGPoint(x: 512, y: 35))
        makeBouncer(at: CGPoint(x: 768, y: 35))
        makeBouncer(at: CGPoint(x: 1024, y: 35))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        randomBall = Int.random(in: 0...4)
        
        let objects = nodes(at: location)
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            if editingMode {
                let size = CGSize(width: Int.random(in: 16...270), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.affectedByGravity = false
                box.physicsBody?.angularVelocity = 15
                box.physicsBody?.isDynamic = false
                addChild(box)
            } else {
                if randomBall == 0 {
                    let ball = SKSpriteNode(imageNamed: "ballYellow")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 1
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.zPosition = 1000
                    ball.position = location
                    ball.position = CGPoint(x: Int.random(in: 24...1000), y: Int.random(in: 250...800))
                    ball.name = "ball"
                    addChild(ball)
                } else if randomBall == 1 {
                    let ball = SKSpriteNode(imageNamed: "ballRed")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 1
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.zPosition = 1000
                    ball.position = location
                    ball.position = CGPoint(x: Int.random(in: 24...1000), y: Int.random(in: 250...800))
                    ball.name = "ball"
                    addChild(ball)
                } else if randomBall == 2 {
                    let ball = SKSpriteNode(imageNamed: "ballCyan")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 1
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.zPosition = 1000
                    ball.position = location
                    ball.position = CGPoint(x: Int.random(in: 24...1000), y: Int.random(in: 250...800))
                    ball.name = "ball"
                    addChild(ball)
                } else if randomBall == 3 {
                    let ball = SKSpriteNode(imageNamed: "ballBlue")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 1
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.zPosition = 1000
                    ball.position = location
                    ball.position = CGPoint(x: Int.random(in: 24...1000), y: Int.random(in: 250...800))
                    ball.name = "ball"
                    addChild(ball)
                } else if randomBall == 4 {
                    let ball = SKSpriteNode(imageNamed: "ballPurple")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 1
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.zPosition = 1000
                    ball.position = location
                    ball.position = CGPoint(x: Int.random(in: 24...1000), y: Int.random(in: 250...800))
                    ball.name = "ball"
                    addChild(ball)
                }
            }
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        slotBase.position = position
        slotGlow.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballLimit += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            ballLimit -= 1
        }
                    
    }
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
}
