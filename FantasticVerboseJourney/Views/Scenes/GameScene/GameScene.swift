//
//  GameScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override init() {
        super.init()
    }
    override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    struct PhysicsCategory {
        static let none      : UInt32 = 0
        //static let all       : UInt32 = UInt32.max
        static let chicken   : UInt32 = 0b1       // 1
        static let pan       : UInt32 = 0b10      // 2
        static let fireball  : UInt32 = 0b11      // 3
    }

    private let hud = HudNode()
    var gameTimer : Timer? = nil
    var timeLeft = 30
    let timerNode = SKLabelNode(text: "")
    var chickenPosition1 : CGPoint = CGPoint(x: 0, y: 0 )
    var chickenPosition2 : CGPoint = CGPoint(x: 0, y: 0 )
    var chickenPosition3 : CGPoint = CGPoint(x: 0, y: 0 )
    var chickenPosition4 : CGPoint = CGPoint(x: 0, y: 0 )
    let duckNode = SKSpriteNode(imageNamed: "duck")
    var duckSuspended : Bool = false
    private var fireballFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        
        let edgeMargin : CGFloat = 0.1
        chickenPosition1 = CGPoint(x: size.width * (1 - edgeMargin), y: size.height * (1 - edgeMargin))
        chickenPosition2 = CGPoint(x: size.width * (1 - edgeMargin), y: size.height * edgeMargin)
        chickenPosition3 = CGPoint(x: size.width * edgeMargin, y: size.height * edgeMargin)
        chickenPosition4 = CGPoint(x: size.width * edgeMargin, y: size.height * (1 - edgeMargin))
        //print("GameScene:: didMove() start \(view)")
        //print("GameScene:: size", size)
        timerNode.position = CGPoint(x: size.width/2, y: size.height * 0.1)
        timerNode.fontName = "DIN Alternate"
        timerNode.fontSize = 30
        timerNode.text = "\(timeLeft)"
        addChild(timerNode)
        
        spawnDuck()
        
        setup()
        
        print("GameScene:: didMove() finished")
    }
    /*
    func getRandomTimeInterval() -> TimeInterval{
        var randomTimeInterval = TimeInterval.random(in: 0.5...4)
        return randomTimeInterval
    }*/
    
    
    // Time of last update(currentTime:) call
    var lastUpdateTime = TimeInterval(0)
    var lastUpdateTime2 = TimeInterval(0)
    // Seconds elapsed since last action
    var timeSinceLastAction = TimeInterval(0)
    var timeSinceLastAction2 = TimeInterval(0)
    // Seconds before performing next action. Choose a default value
    var timeUntilNextAction = TimeInterval(4)
    var timeUntilNextAction2 = TimeInterval(4)
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Chicken spawn at random time interval
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        timeSinceLastAction += delta
        if timeSinceLastAction >= timeUntilNextAction {
            // perform your action
            spawnChickenRandom()
            // reset
            timeSinceLastAction = TimeInterval(0)
            // Randomize seconds until next action
            timeUntilNextAction = Double.random(in: 0 ..< 0.5)
        }
        
        // Pan spawn at random time interval
        let delta2 = currentTime - lastUpdateTime2
        lastUpdateTime2 = currentTime
        timeSinceLastAction2 += delta2
        if timeSinceLastAction2 >= timeUntilNextAction2 {
            // perform your action
            spawnPanRandom()
            // reset
            timeSinceLastAction2 = TimeInterval(0)
            // Randomize seconds until next action
            timeUntilNextAction2 = Double.random(in: 0 ..< 3)
        }

    }

    func spawnDuck() {
        // duck setup
        duckNode.size = CGSize(width: 150, height: 150)
        duckNode.position = CGPoint(x: size.width/2, y: size.height/2 + 10)
        duckNode.zPosition = 5
        duckNode.zRotation = 0
        addChild(duckNode)
        duckNode.run(SKAction.moveBy(x: 0, y: -10, duration: 0.1))
    }
    
    @objc func spawnChickenRandom() {
        let chickenNode = SKSpriteNode(imageNamed: "chicken")//(color: UIColor.yellow, size: CGSize(width: 50, height: 50))
        chickenNode.size = CGSize(width: 100, height: 100)
        chickenNode.physicsBody = SKPhysicsBody(rectangleOf: chickenNode.size)
        chickenNode.physicsBody?.categoryBitMask = PhysicsCategory.chicken
        chickenNode.physicsBody?.contactTestBitMask = PhysicsCategory.fireball
        chickenNode.physicsBody?.collisionBitMask = PhysicsCategory.none
        let randomInt = Int.random(in: 1...4)
        switch randomInt {
        case 1:
            chickenNode.position = chickenPosition1
        case 2:
            chickenNode.position = chickenPosition2
        case 3:
            chickenNode.position = chickenPosition3
        case 4:
            chickenNode.position = chickenPosition4
        default:
            chickenNode.position = chickenPosition1
            print("ERROR: chicken spawn default")
        }
        addChild(chickenNode)
        chickenNode.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0),
                                           SKAction.scale(to: 1, duration: 0.1),
                                           SKAction.wait(forDuration: 1),
                                           SKAction.scale(to: 0, duration: 0.1),
                                           SKAction.removeFromParent()]))
    }
    
    func spawnPanRandom() {
        let panNode = SKSpriteNode(imageNamed: "pan")//color: UIColor.lightGray, size: CGSize(width: 50, height: 50))
        panNode.size = CGSize(width: 100, height: 100)
        panNode.physicsBody = SKPhysicsBody(rectangleOf: panNode.size)
        panNode.physicsBody?.categoryBitMask = PhysicsCategory.pan
        panNode.physicsBody?.contactTestBitMask = PhysicsCategory.fireball
        panNode.physicsBody?.collisionBitMask = PhysicsCategory.none
        let randomInt = Int.random(in: 1...4)
        let edgeMargin : CGFloat = 0.3
        switch randomInt {
        case 1:
            panNode.position = CGPoint(x: size.width * (1 - edgeMargin), y: size.height * (1 - edgeMargin))
            panNode.zRotation = CGFloat(Double.pi)
        case 2:
            panNode.position = CGPoint(x: size.width * (1 - edgeMargin), y: size.height * edgeMargin)
        case 3:
            panNode.position = CGPoint(x: size.width * edgeMargin, y: size.height * edgeMargin)
        case 4:
            panNode.position = CGPoint(x: size.width * edgeMargin, y: size.height * (1 - edgeMargin))
            panNode.zRotation = CGFloat(Double.pi)
        default:
            panNode.position = CGPoint(x: size.width * (1 - edgeMargin), y: size.height * (1 - edgeMargin))
            print("ERROR: pan spawn default")
        }
        addChild(panNode)
        panNode.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0),
                                           SKAction.scale(to: 1, duration: 0.1),
                                           SKAction.wait(forDuration: 1),
                                           SKAction.scale(to: 0, duration: 0.1),
                                           SKAction.removeFromParent()]))
    }

    
    func spawnFireball(position: CGPoint, destination: CGPoint) {
        print("fireball fired")
        
        let fireballAtlas = SKTextureAtlas(named: "fire")
        var fireballFrames : [SKTexture] = []
        let numFrames = fireballAtlas.textureNames.count
        for i in 1...numFrames {
            let fireballTextureName = "fire\(i)"
            fireballFrames.append(fireballAtlas.textureNamed(fireballTextureName))
        }
        let firstFrame = fireballFrames[0]
        
        let fireballNode = SKSpriteNode(texture: firstFrame)//color: UIColor.orange, size: CGSize(width: 10, height: 10))
        fireballNode.size = CGSize(width: 50, height: 50)
        fireballNode.physicsBody?.categoryBitMask = PhysicsCategory.fireball
        //fireballNode.physicsBody?.contactTestBitMask = PhysicsCategory.chicken | PhysicsCategory.pan
        fireballNode.physicsBody?.collisionBitMask = PhysicsCategory.none
        fireballNode.physicsBody = SKPhysicsBody(rectangleOf: fireballNode.size)
        fireballNode.position = position
        addChild(fireballNode)
        /*var dx = CGFloat(chickenPosition1.x)
        var dy = CGFloat(chickenPosition1.y)
        
        let magnitude = sqrt(dx * dx + dy * dy)
        
        dx /= magnitude
        dy /= magnitude
        
        let vector = CGVector(dx: dx, dy: dy)
        
        fireballNode.physicsBody?.applyImpulse(vector)*/
        
        fireballNode.run(SKAction.repeatForever(SKAction.animate(with: fireballFrames, timePerFrame: 0.1)))
        
        /*bear.run(SKAction.repeatForever(
            SKAction.animate(with: bearWalkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)))*/
        
        fireballNode.run(SKAction.move(to: destination, duration: 0.2), completion: {fireballNode.removeFromParent()})
    }

    func duckHit() {
        duckSuspended = true
        let peking = SKSpriteNode(imageNamed: "peking")
        let duckSuspendTime : Double = 1
        peking.position = CGPoint(x: duckNode.position.x, y: duckNode.position.y + 10)
        peking.size = duckNode.size
        duckNode.run(SKAction.sequence([SKAction.moveBy(x: 0, y: 10, duration: 0.05),
                                        SKAction.removeFromParent()]),
                     completion:{
                        self.addChild(peking)
                        //self.duckSuspended = true
        })
        peking.run(SKAction.sequence([SKAction.moveBy(x: 0, y: -10, duration: 0.1),
                                      SKAction.wait(forDuration: duckSuspendTime),
                                      SKAction.moveBy(x: 0, y: 10, duration: 0.05),
                                      SKAction.removeFromParent()]),
                   completion:{
                    self.spawnDuck()
                    self.duckSuspended = false
        })
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        timerNode.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            gameTimer?.invalidate()
            gameTimer = nil
            self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
            let homeMenuScene = HomeMenuScene(size: size)
            print("before home screen", hud.score)
            hud.saveCurrentScore()
            self.view?.presentScene(homeMenuScene)

        }
    }

    
}

// - MARK: Setup helpers
extension GameScene {

    private func setup() {
        backgroundColor = SKColor.darkGray
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)

        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        // hud setup
        hud.setup(size: size)
        addChild(hud)
        hud.resetPoints()
        //addSKButton()
    }
}

// - MARK: Touches responders
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("GameScene:: touchesBegan() start ", touches)
        if duckSuspended == false {
            for touch in touches {
                let touchLocation = touch.location(in: self)
                switch (touchLocation.x, touchLocation.y) {
                case (size.width/2..<size.width, size.height/2..<size.height):
                    duckNode.run(SKAction.rotate(toAngle: CGFloat(tanh(size.height / size.width)), duration: 0.08, shortestUnitArc: true))
                    spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width, y: size.height))//chickenPosition1)//CGPoint(x: size.width - size.width * 0.2, y: size.height - size.width * 0.2))
                    print("touch in top right")
                case (size.width/2..<size.width, 0..<size.height/2):
                    duckNode.run(SKAction.rotate(toAngle: CGFloat(-tanh(size.height / size.width)), duration: 0.08, shortestUnitArc: true))
                    spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width, y: 0))// chickenPosition2)//CGPoint(x: size.width - size.width * 0.2, y: size.width * 0.2))
                    print("touch in bottom right")
                case (0..<size.width/2, 0..<size.height/2):
                    duckNode.run(SKAction.rotate(toAngle: CGFloat(tanh(size.height / size.width) + CGFloat(Double.pi)), duration: 0.08, shortestUnitArc: true))
                    spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: 0, y: 0))//chickenPosition3)//CGPoint(x: size.width * 0.2, y: size.width * 0.2))
                    print("touch in bottom left")
                case (0..<size.width/2, size.height/2..<size.height):
                    duckNode.run(SKAction.rotate(toAngle: CGFloat(-tanh(size.height / size.width) + CGFloat(Double.pi)), duration: 0.08, shortestUnitArc: true))
                    spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: 0, y: size.height))//chickenPosition4)//CGPoint(x: size.width * 0.2, y: size.height - size.width * 0.2))
                    print("touch in top left")
                default:
                    print("touch in no quadrants")
                }
            }
        }
        //print("GameScene:: touchesBegan() end")
    }
/*    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch:UITouch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if touchLocation.x < self.frame.size.width / 2 {
            // Left side of the screen
        } else {
            // Right side of the screen
        }
    }*/

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("GameScene:: touchesEnded begin")
        //        guard let firstTouch = touches.first else { return }
        //        let touchLocationInScene = firstTouch.location(in: self)
    }
}

// - MARK: Physics collision detection
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("Pew pew contact", contact)
        //        let bodyA = contact.bodyA
        //        let bodyB = contact.bodyB
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        // when a chicken spawns in same position as existing chicken
        if ((firstBody.categoryBitMask == PhysicsCategory.chicken) &&
            (secondBody.categoryBitMask == PhysicsCategory.chicken)) {
            if let chicken = firstBody.node as? SKSpriteNode,
                let chicken2 = secondBody.node as? SKSpriteNode { //chicken2 is the initial chicken
                chicken.removeFromParent()
                //print("chicken hit chicken")
            }
        // when pan spawns in same position as existing pan
        } else if ((firstBody.categoryBitMask == PhysicsCategory.pan) &&
            (secondBody.categoryBitMask == PhysicsCategory.pan)) {
            if let pan = firstBody.node as? SKSpriteNode,
                let pan2 = secondBody.node as? SKSpriteNode { // pan2 is initial pan
                pan.removeFromParent()
                //print("pan hit pan")
            }
        // chicken hit by fireball
        } else if ((firstBody.categoryBitMask & PhysicsCategory.chicken != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)) {
            if let chicken = firstBody.node as? SKSpriteNode,
                let fireball = secondBody.node as? SKSpriteNode {
                fireball.removeFromParent()
                chicken.run(SKAction.sequence([SKAction.moveBy(x: 0, y: 10, duration: 0.05),
                                               SKAction.setTexture(SKTexture(imageNamed: "egg")),
                                               SKAction.moveBy(x: 0, y: -10, duration: 0.1)]))
                hud.addPoint()
                print("HIT CHICKEN!")
            }
        // pan hit by fireball
        } else if ((firstBody.categoryBitMask & PhysicsCategory.pan != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)) {
            if let pan = firstBody.node as? SKSpriteNode,
                let fireball = secondBody.node as? SKSpriteNode {
                fireball.run(SKAction.move(to: duckNode.position, duration: 0.2), completion: {fireball.removeFromParent()}) // fireball bounce back
                pan.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.05), SKAction.scale(to: 1, duration: 0.1)]))
                //pan.run(SKAction.move(to: CGPoint(x: (pan.position.x + duckNode.position.x) / 2, y: (pan.position.y + duckNode.position.y) / 2), duration: 0.2))
                if duckSuspended == false {
                    duckHit()
                }
                print("HIT PAN!")
            }
        }
    }
}

// - MARK: - Buttons

// - MARK: Button setup
extension GameScene {
    func addSKButton() {
        let button: SKButton = SKButtonFactory.getButton(delegate: self)

        addChild(button) // - Circular dependency? self.child = button. button.delegate = self...
    }
}

// - MARK: - Button interaction
extension GameScene: SKButtonDelegate {
    func skButtonTapped(sender: SKButton) {
        print("GameScene+SKButtonDelegate:: skButtonTapped()", sender)

        // - DEBUG:
        self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
        let pauseGGScene = PauseScene(returnScene: self)

        self.view?.presentScene(pauseGGScene)
    }
}
