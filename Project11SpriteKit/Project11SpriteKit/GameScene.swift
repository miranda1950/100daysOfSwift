//
//  GameScene.swift
//  Project11SpriteKit
//
//  Created by COBE on 17.08.2022..
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    
    var remainingBalls = 5
    
    var newGameLabel: SKLabelNode!
    
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
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
       
        
        physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 680)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 680)
        addChild(editLabel)
        
        newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        newGameLabel.text = "New Game"
        newGameLabel.position = CGPoint(x: 400, y: 680)
        addChild(newGameLabel)
        
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeSlot(at: CGPoint(x: 128, y: 50), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 50), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 50), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 50), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 50))
        makeBouncer(at: CGPoint(x: 256, y: 50))
        makeBouncer(at: CGPoint(x: 512, y: 50))
        makeBouncer(at: CGPoint(x: 768, y: 50))
        makeBouncer(at: CGPoint(x: 1024, y: 50))
        
        
        
    }
    
    
    
    func makeBouncer(at position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        //isdynamic- false ne mice objekt na screenu
        bouncer.physicsBody?.isDynamic = false
        
        addChild(bouncer)
        
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        
        if objects.contains(newGameLabel) {
            
        newGame()
        }
        
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            
            if editingMode {
                
                //create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "box"
                
                addChild(box)
            } else {
            
                
                
                
                let balls = [SKSpriteNode(imageNamed: "ballGreen"), SKSpriteNode(imageNamed: "ballPurple"),SKSpriteNode(imageNamed: "ballCyan"), SKSpriteNode(imageNamed: "ballYellow"),SKSpriteNode(imageNamed: "ballBlue"), SKSpriteNode(imageNamed: "ballGrey") ]
               
                
                
                guard let ball = balls.randomElement() else { return }
                
                if remainingBalls > 0 {
                
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody?.restitution = 0.4
            ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.position = CGPoint(x:location.x, y: 700)
            ball.name = "ball"
            addChild(ball)
            }
        }
        }
     
        
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
            
        }
        else {
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
    
    func newGame() {
        
        remainingBalls = 5
        
       score = 0F
        
        for node in self.children {
            if node.name == "ball" || node.name == "box" {
                node.removeFromParent()
            }
        }
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        
        if object.name == "box" {
            object.removeFromParent()
            
        }
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        }
        
        else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            remainingBalls -= 1
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
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
}
