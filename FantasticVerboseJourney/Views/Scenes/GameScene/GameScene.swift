//
//  GameScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let hudOverlay = HudNode()

    // ? Too much mutation and coupling
    // scaleFactor is redundant if it is all tuned with variable values everywhere else?
    // Especially if it isn't a constant.
    var scaleFactor: CGFloat = 1_136 / 2 * 0.25 // change value in didMove(to view
    var timeHourglassChance: Int = 15

    let background = SKSpriteNode(texture: Asset.bg.skTextured)
    var textColor = SKColor(
        red: 0.63,
        green: 0.16,
        blue: 0.41,
        alpha: 1.0
    )
    var gameTimer: Timer?
    var timeLeft = 30
    var gameMusic: SKAudioNode!
    let timerNode = SKLabelNode(text: "")

    // - FIXME: ChickenPositioning logic.
    var chickenPosition1: CGPoint = CGPoint(
        x: 0,
        y: 0
    )
    var chickenPosition2: CGPoint = CGPoint(
        x: 0,
        y: 0
    )
    var chickenPosition3: CGPoint = CGPoint(
        x: 0,
        y: 0
    )
    var chickenPosition4: CGPoint = CGPoint(
        x: 0,
        y: 0
    )
    let duckNode = SKSpriteNode(imageNamed: "duck")
    var duckSuspended: Bool = false
    private var fireballFrames: [SKTexture] = []

    // Time of last update(currentTime:) call
    var lastUpdateTime = TimeInterval(0)
    var lastUpdateTime2 = TimeInterval(0)
    // Seconds elapsed since last action
    var timeSinceLastAction = TimeInterval(0)
    var timeSinceLastAction2 = TimeInterval(0)
    // Seconds before performing next action. Choose a default value
    var timeUntilNextAction = TimeInterval(4)
    var timeUntilNextAction2 = TimeInterval(4)

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
        if let musicURL = Bundle.main.url(
            forResource: "gameMusic",
            withExtension: "wav"
        ) {
            gameMusic = SKAudioNode(url: musicURL)
            addChild(gameMusic)
        }

        scaleFactor = size.height * 0.25

        let midWidth: CGFloat = size.width / 2
        background.position = CGPoint(
            x: midWidth,
            y: size.height / 2
        )
        background.size = CGSize(
            width: size.height * 1.5,
            height: size.height * 1.5
        )
        background.zPosition = -10
        addChild(background)
        background.run(
            SKAction.repeatForever(
                SillyAnimation.rotateFasterSpeed
            )
        )

        // Positioning of chicken spawn points on UI.
        let edgeMarginDecimalFraction: CGFloat = 0.15

        let safeAreaPadding: CGFloat = 1 - edgeMarginDecimalFraction

        // - TODO: Standardise the coordinate and design system
        // e.g. pop in pop out SKAction and SKSequence builder reused
        // the 4 spawn positions and slightly inwards-placed position for pans.
        // should all be derived from a central design system
        //
        chickenPosition1 = CGPoint(
            x: size.width * safeAreaPadding,
            y: size.height * safeAreaPadding + 10
        )
        chickenPosition2 = CGPoint(
            x: size.width * safeAreaPadding,
            y: size.height * edgeMarginDecimalFraction + 10
        )
        chickenPosition3 = CGPoint(
            x: size.width * edgeMarginDecimalFraction,
            y: size.height * edgeMarginDecimalFraction + 10
        )
        chickenPosition4 = CGPoint(
            x: size.width * edgeMarginDecimalFraction,
            y: size.height * safeAreaPadding + 10
        )

        // - TODO: Standardise design system for safe area, scaling or various game and UI elements.
        // Refresh ad-hoc scale factors and magic numbers :P

        timerNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        timerNode.position = CGPoint(
            x: midWidth - (scaleFactor * 0.05),
            y: size.height * 0.77
        )
        timerNode.fontName = "DIN Alternate"
        timerNode.fontColor = textColor
        timerNode.fontSize = scaleFactor * 0.2 // 30
        timerNode.text = ": \(timeLeft)"
        addChild(timerNode)

        let timerIcon = SKSpriteNode(imageNamed: "timerIcon")
        timerIcon.anchorPoint = CGPoint(
            x: 0.5,
            y: 0
        )
        timerIcon.position = CGPoint(
            x: timerNode.position.x - (scaleFactor * 0.11),
            y: timerNode.position.y
        )
        timerIcon.size = CGSize(
            width: scaleFactor * 0.15,
            height: scaleFactor * 0.15
        )
        addChild(timerIcon)

        spawnDuck()

        setup()

        print("GameScene:: didMove() finished")
    }

    // - FIXME: ? don't need to calculate things on every single frame update.
    // Calculate based on seconds timer somewhere else
    // calculation handler
    // spawn handler? chance timing
    // the update can then retrieve the computed variable (keeps polling/pinging)
    // ~slightly less performance impact?
    // Does not need to contain calculate logic for every update.
    // Extend gamescene to conform to the SpawnHandler delegate?
    // or separate even further with a gamestate handler

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
            timeUntilNextAction = Double.random(in: 0 ..< 1)
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
        duckNode.size = CGSize(
            width: scaleFactor,
            height: scaleFactor
        )
        duckNode.anchorPoint = CGPoint(
            x: 0.5,
            y: 0.4
        )
        duckNode.position = CGPoint(
            x: size.width / 2,
            y: size.height / 2 + 10
        )
        duckNode.zPosition = 5
        duckNode.zRotation = 0
        addChild(duckNode)
        duckNode.run(
            SillyAnimation.boopDownAnimation
        )

    }

    // -- FIXME: spawnChickenRandom does more than spawn a chicken...
    @objc func spawnChickenRandom() {
        let chickenNode = SKSpriteNode(imageNamed: "chicken")
        chickenNode.size = CGSize(width: scaleFactor * 0.8,
            height: scaleFactor * 0.8)
        chickenNode.zPosition = 1
        chickenNode.physicsBody = SKPhysicsBody(circleOfRadius: chickenNode.size.height / 4)
        chickenNode.physicsBody?.categoryBitMask = PhysicsCategory.chicken
        chickenNode.physicsBody?.contactTestBitMask = PhysicsCategory.fireball
        chickenNode.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let mobSpawnPositions = [chickenPosition1, chickenPosition2, chickenPosition3, chickenPosition3]
        chickenNode.position = mobSpawnPositions.randomElement() ?? chickenPosition1

        // using timeHourglassChance value as an inverse chance for calculation?
        // activates morphing of a spawned chickenNode to be a timeHourglass
        // but only when the randomised number in the range of 1...timeHourglassInverseChance is 1.
        // e.g. 1 out of 15. (Samuel thought this was an extra step counter-intuitive to reading the code.
        // because 15 is not the chance, and the larger the `timeHourglassChance` is, the less likely it is to have a
        // timeHourglass spawn?
        // Intention: TODO: Change to be more straightforward and with less side effects
        let randomTimeHourglass = Int.random(in: 1...timeHourglassChance) // chance/frequency of timeHourglass
        if randomTimeHourglass == 1 {
            chickenNode.physicsBody?.categoryBitMask = PhysicsCategory.timeHourglass
            chickenNode.texture = SKTexture(imageNamed: "timerIcon")
            chickenNode.size = CGSize(
                width: scaleFactor * 0.3,
                height: scaleFactor * 0.3
            )
            chickenNode.run(
                SKAction.repeatForever(
                    SKAction.rotate(
                        byAngle: -2 * CGFloat(Double.pi),
                        duration: 2
                    )

                )
            )
        }

        addChild(chickenNode)

        chickenNode.run(
            SKAction.sequence(
                [
                    SillyAnimation.scaleSizeToZeroInstant,
                    SillyAnimation.scaleSizeToNormal,
                    SillyAnimation.boopDownAnimation,
                    SKAction.run {
                        chickenNode.zPosition = CGFloat(2)
                    },
                    SKAction.wait(forDuration: 1),
                    SillyAnimation.scaleSizeToZero,
                    SKAction.removeFromParent()
                ]
            )
        )
    }

    func spawnPanRandom() {
        let panNode = SKSpriteNode(imageNamed: "pan")
        panNode.size = CGSize(
            width: scaleFactor * 0.8,
            height: scaleFactor * 0.8
        )
        panNode.physicsBody = SKPhysicsBody(circleOfRadius: panNode.size.height / 6)
        panNode.physicsBody?.categoryBitMask = PhysicsCategory.fryingPan
        panNode.physicsBody?.contactTestBitMask = PhysicsCategory.fireball
        panNode.physicsBody?.collisionBitMask = PhysicsCategory.none

        let randomInt = Int.random(in: 1...4)
        let edgeMargin: CGFloat = 0.3
        switch randomInt {
        case 1:
            panNode.position = CGPoint(
                x: size.width * (1 - edgeMargin),
                y: size.height * (1 - edgeMargin)
            )

            panNode.zRotation = CGFloat(Double.pi)
        case 2:
            panNode.position = CGPoint(
                x: size.width * (1 - edgeMargin),
                y: size.height * edgeMargin
            )
        case 3:
            panNode.position = CGPoint(
                x: size.width * edgeMargin,
                y: size.height * edgeMargin
            )
        case 4:
            panNode.position = CGPoint(
                x: size.width * edgeMargin,
                y: size.height * (1 - edgeMargin)
            )

            panNode.zRotation = CGFloat(Double.pi)
        default:
            panNode.position = CGPoint(
                x: size.width * (1 - edgeMargin),
                y: size.height * (1 - edgeMargin)
            )

            print("ERROR: pan spawn default")
        }
        addChild(panNode)
        panNode.run(
            SKAction.sequence(
                [
                    SillyAnimation.scaleSizeToZeroInstant,
                    SillyAnimation.scaleSizeToNormal,
                    SKAction.wait(forDuration: 1),
                    SillyAnimation.scaleSizeToZero,
                    SKAction.removeFromParent()
                ]
            )
        )
    }

    fileprivate func spawnDuckArm(_ angle: CGFloat) {
        // SPAWN ARM
        let duckArm = SKSpriteNode(imageNamed: "arm")
        duckArm.size = CGSize(
            width: scaleFactor * 0.85,
            height: scaleFactor * 0.85
        )
        duckArm.anchorPoint = CGPoint(
            x: 0,
            y: 0.5
        )
        duckArm.position = CGPoint(
            x: size.width / 2,
            y: size.height / 2
        )
        duckArm.zPosition = 5
        duckArm.zRotation = angle
        addChild(duckArm)
        duckArm.run(
            SKAction.sequence(
                [
                    SillyAnimation.scaleSizeToZeroInstant,
                    SillyAnimation.scaleSizeToNormal,
                    SillyAnimation.scaleSizeToZero,
                    SKAction.removeFromParent()
                ]
            )
        )
    }
    
    func spawnFireball(
        position: CGPoint,
        destination: CGPoint,
        angle: CGFloat
    ) { // also spawns arm sprite
        print("fireball fired")
        // setup fireball animation
        let fireballAtlas = SKTextureAtlas(named: "fire")
        var fireballFrames: [SKTexture] = []
        let numFrames = fireballAtlas.textureNames.count
        // ... fire1 fire2 fire3.
        for fireSpriteAtlasAssetNameIdSuffix in 1...numFrames {
            let fireballTextureName = "fire\(fireSpriteAtlasAssetNameIdSuffix)"
            fireballFrames.append(
                fireballAtlas.textureNamed(fireballTextureName)
            )

        }
        let firstFrame = fireballFrames[0]

        let fireballNode = SKSpriteNode(texture: firstFrame)
        fireballNode.size = CGSize(
            width: scaleFactor * 0.5,
            height: scaleFactor * 0.5
        )
        fireballNode.physicsBody?.categoryBitMask = PhysicsCategory.fireball
        //fireballNode.physicsBody?.contactTestBitMask = PhysicsCategory.chicken | PhysicsCategory.pan
        fireballNode.physicsBody?.collisionBitMask = PhysicsCategory.none
        fireballNode.anchorPoint = CGPoint(
            x: 0,
            y: 0.5
        )
        fireballNode.physicsBody = SKPhysicsBody(
            circleOfRadius: fireballNode.size.width / 4,
            center: CGPoint(
                x: scaleFactor * 0.25,
                y: 0.5
            )
        )

        fireballNode.position = position
        fireballNode.zPosition = 6
        fireballNode.zRotation = angle
        addChild(fireballNode)
        // start fireball animation
        fireballNode.run(

            SKAction.repeatForever(
                SKAction.animate(
                    with: fireballFrames,
                    timePerFrame: 0.05
                )
            )
        )
        // move fireball
        fireballNode.run(
            SKAction.move(
                to: destination,
                duration: 0.5
            ),
            completion: {
                fireballNode.removeFromParent()

            }
        )

        spawnDuckArm(angle) // - FIXME: coupling + temporal coupling. spawnDuckArm and fireball not dependent on each other..

    }

    // duck gets hit by a fireball, becomes fried into a roast peking duck
    func duckHitIntoARoastPekingDuck() {
        duckSuspended = true
        let peking = SKSpriteNode(imageNamed: "peking")
        let duckSuspendTime: Double = 1
        peking.position = CGPoint(
            x: duckNode.position.x,
            y: duckNode.position.y + 10
        )
        peking.size = duckNode.size
        duckNode.run(
            SKAction.sequence(
                [
                    SillyAnimation.boopUpAnimation,
                    SKAction.removeFromParent()
                ]
            ),
            completion: {
                self.addChild(peking)
            }
        )
        peking.run(
            SKAction.sequence(
                [
                    SillyAnimation.boopDownAnimation,
                    SKAction.wait(forDuration: duckSuspendTime),
                    SillyAnimation.boopUpAnimation,
                    SKAction.removeFromParent()
                ]
            ),
            completion: {
                self.spawnDuck()
                self.duckSuspended = false
            }
        )
    }

    func addTime() {
        timerNode.run(
            SKAction.sequence(
                [
                    SillyAnimation.scaleSizeEmbiggen,
                    SKAction.scale(
                        to: 1,
                        duration: 0.05)
                ]
            )
        )
        timeLeft += 1 // amount of time to add
        timerNode.text = ": \(timeLeft)"
    }

    func bgFlash() {
        background.run(
            SKAction.sequence(
                [
                    SKAction.colorize(
                        with: UIColor(
                            hue: 0.15,
                            saturation: 1,
                            brightness: 0.5,
                            alpha: 1
                        ),
                        colorBlendFactor: 0.3,
                        duration: 0
                    ),
                    SKAction.colorize(
                        with: UIColor.black,
                        colorBlendFactor: 0,
                        duration: 0.5
                    )
                ]
            )
        )
    }

    @objc func onTimerFires() {
        timeLeft -= 1
        timerNode.text = ": \(timeLeft)"

        switch timeLeft {
        case 0..<6:
            timeHourglassChance = 2 // ? unused.
            bgFlash()
        case 6..<11:
            timeHourglassChance = 4
            bgFlash()
        case 11..<14:
            timeHourglassChance = 5
        default:
            background.colorBlendFactor = 0
            timeHourglassChance = 15
        }

        if timeLeft <= 0 {
            gameTimer?.invalidate()
            gameTimer = nil
            //self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
            let homeMenuScene = HomeMenuScene(size: size)
            print(
                "before home screen",
                hudOverlay.score
            )
            hudOverlay.saveCurrentScore()
            let homeSceneTransition = SKTransition.push(
                with: .down,
                duration: 0.5
            )
            self.view?.presentScene(
                homeMenuScene,
                transition: homeSceneTransition
            )

        }
    }
}

// - MARK: Setup helpers
extension GameScene {

    private func setup() {
        backgroundColor = SKColor.darkGray
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(onTimerFires),
            userInfo: nil,
            repeats: true
        )

        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        // HUD setup
        hudOverlay.setup(size: size)
        addChild(hudOverlay)
        hudOverlay.resetPoints()

    }
}

// - MARK: Touches responders
extension GameScene {

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        if duckSuspended == false {
            for touch in touches {
                let touchLocation = touch.location(in: self)
                var orientAngle: CGFloat

                switch (touchLocation.x, touchLocation.y) {

                case (size.width / 2..<size.width, size.height / 2..<size.height):
                    orientAngle = CGFloat(tanh(size.height / size.width)
                    )

                    duckNode.run(
                        SKAction.rotate(
                            toAngle: orientAngle,
                            duration: 0.08,
                            shortestUnitArc: true
                        )
                    )

                    spawnFireball(position: CGPoint(x: size.width / 2,
                        y: size.height / 2),
                        destination: CGPoint(x: size.width,
                            y: size.height),
                        angle: orientAngle)
                    print("touch in top right")
                case (size.width / 2..<size.width, 0..<size.height / 2):
                    orientAngle = CGFloat(-tanh(size.height / size.width)
                    )

                    duckNode.run(
                        SKAction.rotate(
                            toAngle: orientAngle,
                            duration: 0.08,
                            shortestUnitArc: true
                        )
                    )

                    spawnFireball(
                        position: CGPoint(
                            x: size.width / 2,
                            y: size.height / 2
                        ),
                        destination: CGPoint(
                            x: size.width,
                            y: 0
                        ),
                        angle: orientAngle
                    )
                    print("touch in bottom right")
                case (0..<size.width / 2, 0..<size.height / 2):
                    orientAngle = CGFloat(
                        tanh(size.height / size.width) + CGFloat(Double.pi)
                    )

                    duckNode.run(
                        SKAction.rotate(
                            toAngle: orientAngle,
                            duration: 0.08,
                            shortestUnitArc: true
                        )
                    )

                    spawnFireball(
                        position: CGPoint(
                            x: size.width / 2,
                            y: size.height / 2
                        ),
                        destination: CGPoint(
                            x: 0,
                            y: 0
                        ),
                        angle: orientAngle
                    )
                    print("touch in bottom left")
                case (0..<size.width / 2, size.height / 2..<size.height):
                    orientAngle = CGFloat(
                        -tanh(size.height / size.width) + CGFloat(Double.pi)
                    )

                    duckNode.run(
                        SKAction.rotate(
                            toAngle: orientAngle,
                            duration: 0.08,
                            shortestUnitArc: true
                        )
                    )

                    spawnFireball(
                        position: CGPoint(
                            x: size.width / 2,
                            y: size.height / 2
                        ),
                        destination: CGPoint(
                            x: 0,
                            y: size.height
                        ),
                        angle: orientAngle
                    )
                    print("touch in top left")
                default:
                    print("touch in no quadrants")
                }
            }
            duckNode.run(
                SKAction.sequence(
                    [
                        SillyAnimation.scaleSizeEmbiggen,
                        SillyAnimation.scaleSizeToNormal
                    ]
                )
            )
        }
    }

    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        //print("GameScene:: touchesEnded begin")
        //        guard let firstTouch = touches.first else { return }
        //        let touchLocationInScene = firstTouch.location(in: self)
    }
}

// - MARK: - Buttons

// - MARK: Button setup
extension GameScene {
    func addSKButton() {
        let button: SKButton = SKButtonFactory.getButton(delegate: self)

        addChild(button)
    }
}

// - MARK: - Button interaction
extension GameScene: SKButtonDelegate {
    func skButtonTapped(sender: SKButton) {
        print("GameScene+SKButtonDelegate:: skButtonTapped()",
            sender)

        // - DEBUG:
        self.removeAllChildren() // clear -- TODO: Move this code to the hot reload injection refresher.
        let pauseGGScene = PauseScene(returnScene: self)

        self.view?.presentScene(pauseGGScene)
    }
}
