//
//  HomeMenuScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import SpriteKit.SKScene
import GameplayKit

class HomeMenuScene: SKScene {

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
        print("HomeMenuScene:: didMove() start \(view)")
        print("HomeMenuScene:: size", size)
        // title setup
        let titleNode = SKShapeNode(rectOf: CGSize(width: 300, height: 150))
        titleNode.fillColor = SKColor.red
        titleNode.position = CGPoint(x: size.width/2, y: size.height - 100)
        addChild(titleNode)
        setup()
        // high score label setup
        let highscoreLabel = SKLabelNode(text: "12")
        highscoreLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        highscoreLabel.fontName = "DIN Alternate"
        highscoreLabel.fontColor = SKColor.black
        highscoreLabel.fontSize = 50
        addChild(highscoreLabel)
            
        
        print("HomeMenuScene:: didMove() finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}

// - MARK: Setup helpers
extension HomeMenuScene {
    
    private func setup() {
        backgroundColor = SKColor.yellow
        
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        addSKButton()
    }
}

// - MARK: Touches responders
extension HomeMenuScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("HomeMenuScene:: touchesBegan() start ", touches)
        
        print("HomeMenuScene:: touchesBegan() end")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("HomeMenuScene:: touchesEnded begin")
        //        guard let firstTouch = touches.first else { return }
        //        let touchLocationInScene = firstTouch.location(in: self)
    }
}

// - MARK: Physics collision detection
extension HomeMenuScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Pew pew contact", contact)
        //        let bodyA = contact.bodyA
        //        let bodyB = contact.bodyB
    }
}

// - MARK: - Buttons

// - MARK: Button setup
extension HomeMenuScene {
    func addSKButton() {
        let button: SKButton = SKButtonFactory.getButton(delegate: self)
        button.position = CGPoint(x: size.width/2, y: size.width/2)
        button.color = SKColor.blue
        button.size = CGSize(width: 250, height: 100)
        addChild(button) // - Circular dependency? self.child = button. button.delegate = self...
    }
}

// - MARK: - Button interaction
extension HomeMenuScene: SKButtonDelegate {
    func skButtonTapped(sender: SKButton) {
        print("HomeMenuScene+SKButtonDelegate:: skButtonTapped()", sender)
        
        // - DEBUG:
        self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = .aspectFit
        self.view?.presentScene(gameScene)
    }
}
