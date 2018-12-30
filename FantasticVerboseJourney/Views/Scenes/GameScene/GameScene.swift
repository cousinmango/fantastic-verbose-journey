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
    
    
    override func didMove(to view: SKView) {
        print("GameScene:: didMove() start \(view)")
        print("GameScene:: size", size)
        setup()
        /*     // chicken setup
         run(SKAction.repeatForever(SKAction.sequence([
         SKAction.run(spawnChickenRandom),
         SKAction.wait(forDuration: getRandomTimeInterval())]))) // - TODO: randomise time interval
         
         run(SKAction.repeatForever(SKAction.sequence([
         SKAction.run(spawnPanRandom),
         SKAction.wait(forDuration: getRandomTimeInterval())])))
         */
        //let timer = Timer.scheduledTimer(timeInterval: getRandomTimeInterval(), target: self, selector: #selector(spawnChickenRandom), userInfo: nil, repeats: true)
        
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
            timeUntilNextAction = CDouble(arc4random_uniform(6))
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
            timeUntilNextAction2 = CDouble(arc4random_uniform(6))
        }

    }
    
    @objc func spawnChickenRandom() {
        let chickenNode = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 50, height: 50))
        let randomInt = Int.random(in: 1...4)
        let edgeMargin : CGFloat = size.width * 0.2
        switch randomInt {
        case 1:
            chickenNode.position = CGPoint(x: size.width - edgeMargin, y: size.height - edgeMargin)
        case 2:
            chickenNode.position = CGPoint(x: size.width - edgeMargin, y: edgeMargin)
        case 3:
            chickenNode.position = CGPoint(x: edgeMargin, y: edgeMargin)
        case 4:
            chickenNode.position = CGPoint(x: edgeMargin, y: size.height - edgeMargin)
        default:
            chickenNode.position = CGPoint(x: size.width - edgeMargin, y: size.height - edgeMargin)
            print("ERROR: chicken spawn default")
        }
        addChild(chickenNode)
        chickenNode.run(SKAction.sequence([SKAction.wait(forDuration: 1),
                                           SKAction.removeFromParent()]))
    }
    
    func spawnPanRandom() {
        let panNode = SKSpriteNode(color: UIColor.black, size: CGSize(width: 50, height: 50))
        let randomInt = Int.random(in: 1...4)
        let edgeMargin : CGFloat = size.width * 0.4
        switch randomInt {
        case 1:
            panNode.position = CGPoint(x: size.width - edgeMargin, y: size.height - edgeMargin)
        case 2:
            panNode.position = CGPoint(x: size.width - edgeMargin, y: edgeMargin)
        case 3:
            panNode.position = CGPoint(x: edgeMargin, y: edgeMargin)
        case 4:
            panNode.position = CGPoint(x: edgeMargin, y: size.height - edgeMargin)
        default:
            panNode.position = CGPoint(x: size.width - edgeMargin, y: size.height - edgeMargin)
            print("ERROR: pan spawn default")
        }
        addChild(panNode)
        panNode.run(SKAction.sequence([SKAction.wait(forDuration: 1),
                                           SKAction.removeFromParent()]))
    }

    
    func spawnFireball(position: CGPoint, destination: CGPoint) {
        let fireball = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 10, height: 10))
        let moveToChicken = SKAction.move(to: destination, duration: 0.5)
        fireball.position = position
        addChild(fireball)
        fireball.run(moveToChicken)
    }
    
}

// - MARK: Setup helpers
extension GameScene {

    private func setup() {
        backgroundColor = SKColor.cyan
        
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        // duck setup
        let duckNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        duckNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(duckNode)
        //addSKButton()
    }
}

// - MARK: Touches responders
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesBegan() start ", touches)
        for touch in touches {
            let touchLocation = touch.location(in: self)
            switch (touchLocation.x, touchLocation.y) {
            case (size.width/2..<size.width, size.height/2..<size.height):
                spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width - size.width * 0.2, y: size.height - size.width * 0.2))
                print("touch in top right")
            case (size.width/2..<size.width, 0..<size.height/2):
                spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width - size.width * 0.2, y: size.width * 0.2))
                print("touch in bottom right")
            case (0..<size.width/2, 0..<size.height/2):
                spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width * 0.2, y: size.width * 0.2))
                print("touch in bottom left")
            case (0..<size.width/2, size.height/2..<size.height):
                spawnFireball(position: CGPoint(x: size.width/2, y: size.height/2), destination: CGPoint(x: size.width * 0.2, y: size.height - size.width * 0.2))
                print("touch in top left")
            default:
                print("touch in no quadrants")
            }
        }
        print("GameScene:: touchesBegan() end")
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
        print("GameScene:: touchesEnded begin")
        //        guard let firstTouch = touches.first else { return }
        //        let touchLocationInScene = firstTouch.location(in: self)
    }
}

// - MARK: Physics collision detection
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Pew pew contact", contact)
        //        let bodyA = contact.bodyA
        //        let bodyB = contact.bodyB
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
