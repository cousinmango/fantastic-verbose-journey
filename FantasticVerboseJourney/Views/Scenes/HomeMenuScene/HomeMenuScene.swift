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
    
    let hud = HudNode()
    private let scoreKey = "DUCKMAN_HIGHSCORE"
    private var highscore : Int = 0
    private let currentScoreKey = "CURRENT_SCORE"
    private var currentScore : Int = 0
    
    override init() {
        super.init()
    }

    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func resetDefaults() { // resets high score
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: "DUCKMAN_HIGHSCORE")
        }
    }

    override func didMove(to view: SKView) {
        print("on home screen", hud.score)
        // resetDefaults()
        print("HomeMenuScene:: didMove() start \(view)")
        print("HomeMenuScene:: size", size)
        
        
        // title setup
        let titleNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 300, height: 150))
        titleNode.position = CGPoint(x: size.width/2, y: size.height - 100)
        addChild(titleNode)
        
        let logoNode = SKSpriteNode(imageNamed: "duck")
        logoNode.position = CGPoint(x: size.width/2, y: size.height/2)
        logoNode.size = CGSize(width: 150, height: 150)
        addChild(logoNode)

        let defaults = UserDefaults.standard
        
        currentScore = defaults.integer(forKey: currentScoreKey)
        let scoreLabel = SKLabelNode(text: String(currentScore))
        scoreLabel.fontName = "DIN Alternate"
        scoreLabel.fontSize = 80
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.6)
        addChild(scoreLabel)

        highscore = defaults.integer(forKey: scoreKey)
        let highscoreLabel = SKLabelNode(text: String(highscore))
        highscoreLabel.fontName = "DIN Alternate"
        highscoreLabel.fontSize = 40
        highscoreLabel.position = CGPoint(x: 50, y: 50)
        addChild(highscoreLabel)
        
        // ___________TEMP__________
        
        let tempTitleLabel = SKLabelNode(text: "SILLY DUCKMAN")
        tempTitleLabel.fontName = "DIN Alternate"
        tempTitleLabel.fontSize = 40
        tempTitleLabel.position = CGPoint(x: titleNode.position.x, y: titleNode.position.y - 15)
        addChild(tempTitleLabel)
        
        // ^^^^^^^^^^TEMP^^^^^^^^^^
        
        setup()

        let startButton = createSKButtonStart()
        let startButtonLabel = SKLabelNode(text: "START")
        startButtonLabel.fontName = "DIN Alternate"
        startButtonLabel.fontSize = 30
        startButton.addChild(startButtonLabel)
        addChild(startButton)
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
    func createSKButtonStart() -> SKButton {
        let button: SKButton = SKButtonFactory.getButton(delegate: self)
        button.position = CGPoint(x: size.width/2, y: size.width/2)
        button.zPosition = -3
        button.color = SKColor.blue
        button.size = CGSize(width: 250, height: 100)
        
        return button
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
