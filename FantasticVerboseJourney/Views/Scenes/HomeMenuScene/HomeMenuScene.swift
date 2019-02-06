//
//  HomeMenuScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKScene
import GameplayKit

class HomeMenuScene: SKScene {

    let hud = HudNode()
    let gameScene = GameScene()
    var homeMusic: SKAudioNode!
    private let scoreKey = "DUCKMAN_HIGHSCORE"
    private var highscore: Int = 0
    private let currentScoreKey = "CURRENT_SCORE"
    private var currentScore: Int = 0
    let background = SKSpriteNode(imageNamed: "BG")
    var scaleFactor: CGFloat = 284 // default minumum - change value in didMove(to view
    var startButton: SKButton!

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
        dictionary.keys.forEach { _ in
            defaults.removeObject(forKey: "DUCKMAN_HIGHSCORE")
        }
    }

    override func didMove(to view: SKView) {
        if let musicURL = Bundle.main.url(forResource: "homeMusic", withExtension: "wav") {
            homeMusic = SKAudioNode(url: musicURL)
            addChild(homeMusic)
        }

        scaleFactor = size.height * 0.25 // = 284 on iPhone SE

        print("on home screen", hud.score)
        // resetDefaults()
        print("HomeMenuScene:: didMove() start \(view)")
        print("HomeMenuScene:: size", size)

        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.height * 1.5, height: size.height * 1.5)//(width: size.width, height: size.height)
        background.zPosition = -10
        addChild(background)
        background.run(SKAction.repeatForever(SKAction.rotate(byAngle: -2 * CGFloat(Double.pi), duration: 25)))

        // title setup
        let titleNode = SKSpriteNode(imageNamed: "title")//color: UIColor.red, size: CGSize(width: 300, height: 150))
        titleNode.position = CGPoint(x: size.width/2, y: size.height * 0.85)
        titleNode.setScale(scaleFactor * 0.0013)
        //titleNode.size = CGSize(width: scaleFactor * 3, height: titleNode.size.y * scaleFactor)
        addChild(titleNode)
        titleNode.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0),
                                         SKAction.wait(forDuration: 0.8),
                                           SKAction.scale(to: scaleFactor * 0.0015, duration: 0.1),
                                           SKAction.scale(to: scaleFactor * 0.0013, duration: 0.1)]))

        let logoNode = SKSpriteNode(imageNamed: "duck")
        logoNode.anchorPoint = CGPoint(x: 0.5, y: 0.4)
        logoNode.position = CGPoint(x: size.width/2, y: size.height/2)
        logoNode.size = CGSize(width: scaleFactor, height: scaleFactor)
        addChild(logoNode)
        logoNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: -2 * CGFloat(Double.pi), duration: 4)))
        let scaleUpDown = SKAction.repeatForever(SKAction.sequence([SKAction.scale(to: 0.85, duration: 0.8), SKAction.scale(to: 1, duration: 0.8)]))
        scaleUpDown.timingMode = SKActionTimingMode.easeInEaseOut
        logoNode.run(scaleUpDown)

        let defaults = UserDefaults.standard

        currentScore = defaults.integer(forKey: currentScoreKey)
        let scoreLabel = SKLabelNode(text: String(currentScore))
        scoreLabel.fontName = "DIN Alternate"
        scoreLabel.fontColor = SKColor(red: 0.63, green: 0.16, blue: 0.41, alpha: 1.0)
        scoreLabel.fontSize = scaleFactor * 0.4//80
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.64)
        addChild(scoreLabel)
        scoreLabel.run(SKAction.sequence([SKAction.scale(to: 1, duration: 0),
                                         SKAction.wait(forDuration: 0.2),
                                         SKAction.scale(to: 1.4, duration: 0.1),
                                         SKAction.wait(forDuration: 0.3),
                                         SKAction.scale(to: 1, duration: 0.1)]))

        highscore = defaults.integer(forKey: scoreKey)
        let highscoreLabel = SKLabelNode(text: "BEST: \(highscore)")//String(highscore))
        highscoreLabel.fontName = "DIN Alternate"
        highscoreLabel.fontColor = SKColor(red: 0.63, green: 0.16, blue: 0.41, alpha: 1.0)
        highscoreLabel.fontSize = scaleFactor * 0.15//40
        highscoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.32)
        addChild(highscoreLabel)

        /* ___________TEMP__________
        
        let tempTitleLabel = SKLabelNode(text: "SILLY DUCKMAN")
        tempTitleLabel.fontName = "DIN Alternate"
        tempTitleLabel.fontSize = 40
        tempTitleLabel.position = CGPoint(x: titleNode.position.x, y: titleNode.position.y - 15)
        addChild(tempTitleLabel)
        
         ^^^^^^^^^^TEMP^^^^^^^^^^ */

        setup()

        startButton = createSKButtonStart()
        /*let startButtonLabel = SKLabelNode(text: "START")
        startButtonLabel.fontName = "DIN Alternate"
        startButtonLabel.fontSize = 30*/
        //startButton.size = CGSize(width: startButton.width * scaleFactor, height: startButton.height * scaleFactor)
        //startButton.addChild(startButtonLabel)
        addChild(startButton)
        startButton.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0),
                                           SKAction.wait(forDuration: 1.1),
                                           SKAction.scale(to: scaleFactor * 0.0035, duration: 0.1),
                                           SKAction.scale(to: scaleFactor * 0.003, duration: 0.1)]))
        print("HomeMenuScene:: didMove() finished")
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}

// - MARK: Setup helpers
extension HomeMenuScene {

    private func setup() {
        //backgroundColor = SKColor.yellow

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
        button.texture = SKTexture(imageNamed: "startButton")
        button.position = CGPoint(x: size.width/2, y: size.height * 0.18)
        button.zPosition = -3
        //button.color = SKColor.blue
        //button.size = CGSize(width: 250, height: 100)
        button.setScale(scaleFactor * 0.003)//CGSize(width: button.size.width * scaleFactor * 0.003, height: button.size.height * scaleFactor * 0.003)

        return button
    }
}

// - MARK: - Button interaction
extension HomeMenuScene: SKButtonDelegate {
    func skButtonTapped(sender: SKButton) {
        print("HomeMenuScene+SKButtonDelegate:: skButtonTapped()", sender)

        // - DEBUG:
        let gameSceneTransition = SKTransition.push(with: .up, duration: 0.5)
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = .aspectFit
        self.view?.presentScene(gameScene, transition: gameSceneTransition)
        //self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
    }
}
