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
        
        
        
        print("GameScene:: didMove() finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func spawnChicken(position: CGPoint) {
        let chickenNode = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 50, height: 50))
        chickenNode.position = position
        addChild(chickenNode)
    }
    
}

// - MARK: Setup helpers
extension GameScene {
    
    private func setup() {
        backgroundColor = SKColor.magenta
        
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        // duck setup
        let duckNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        duckNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(duckNode)
        // chicken setup
        let edgeMargin : CGFloat = size.width * 0.2
        spawnChicken(position: CGPoint(x: size.width - edgeMargin, y: size.height - edgeMargin))
        spawnChicken(position: CGPoint(x: size.width - edgeMargin, y: edgeMargin))
        spawnChicken(position: CGPoint(x: edgeMargin, y: edgeMargin))
        spawnChicken(position: CGPoint(x: edgeMargin, y: size.height - edgeMargin))

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
                print("touch in top right")
            case (size.width/2..<size.width, 0..<size.height/2):
                print("touch in bottom right")
            case (0..<size.width/2, 0..<size.height/2):
                print("touch in bottom left")
            case (0..<size.width/2, size.height/2..<size.height):
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
