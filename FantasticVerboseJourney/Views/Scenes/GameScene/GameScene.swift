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
    var spawnManager: SpawnManager!
    var timeManager: TimeManager!
    
    
    override init() {
        super.init()
    }
    override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func sceneDidLoad() {
        // setup managers
        self.spawnManager = SpawnManager(spawnScene: self) // weak var ref like delegate
        self.timeManager = TimeManager(delegate: self, initialTimeSeconds: 5)


        setupSpawn()
    }
    override func didMove(to view: SKView) {

    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // print("Current time \(currentTime)")
    }

}

// - MARK: Spawn
extension GameScene {
    fileprivate func spawnChickenRunner() {
        // SpawnTest
        let testPositions = [
            SpawnPositionProportion.northWestern,
            SpawnPositionProportion.northEastern,
            SpawnPositionProportion.southWestern,
            SpawnPositionProportion.southEastern
        ]
        let timedSpawnDeathAnimation: SKAction = SillyAnimation.spawnEphemeral()

        let chickenMobEphemeralSpawnDeathOneSecond = MobFactory.createChicken( initAnimation: timedSpawnDeathAnimation)
        let chickenSprite = spawnManager.spawn(
            spawnMob: chickenMobEphemeralSpawnDeathOneSecond,
            possibleSpawnPositions: testPositions
        ) // Wonder if memory leak
    }

    func setupSpawn() {

        // Example of scaled point
        let testFlyPoint: CGPoint = spawnManager
            .getPositionScaled(
                sizeToScaleWithin: self.size,
                spawnPointProportion: CGPoint(
                    x: 1.0,
                    y: 1.0 // very top right corner. 100%, 100% of scene.
                )
        )
        let flyAction = SKAction.move(to: testFlyPoint, duration: 3)

    }
}

extension GameScene {

    fileprivate func startMusic() {
        guard let musicUrl = SoundAssetUrl.gameMusicUrl else { return }

        let gameMusic = SKAudioNode(url: musicUrl)
        addChild(gameMusic)
    }

    func spawnFireballSetup() {

        // stringName: UIImage
//        let fireballAtlasDictionary = [ "fire1" : Asset.fire]
//        let fireballAtlas = SKTextureAtlas(dictionary:
//        )
    }
    func spawnFireball(
        startPosition: CGPoint,
        destination: CGPoint,
        angle: CGFloat
        ) {

        // ? re init fireball atlas
        // Readability immutability and maintainability trumps performance
        // Dev time vs CPU time :P

        /** from doc
         This design also offers your artists the ability to experiment
         with new textures without requiring that your game be rebuilt. The
         artists drop the textures into the app bundle. When the app is
         relaunched, SpriteKit automatically discovers the textures (overriding
         any previous versions built into the texture atlases).
         **/
        /* use samew rationale for maintaining everything in an enum for
         design system. Artistic tuning easier than having a single objet for
         each bespoke object without clear design system.
         */

        // -- FIXME: hmm reinit. can just preload this and store somewhere else in memory.
        let fireballAtlas = SKTextureAtlas(named: "fire")

        let fireballFrames = fireballAtlas.textureNames
            .map(
                {
                    fireballAtlas.textureNamed($0)
                }
        )

        let fireballNode = SKSpriteNode(texture: fireballFrames.first!)

        fireballNode.position = startPosition
        let loopFireballFrames = SKAction.repeatForever(
            SKAction.animate(
                with: fireballFrames,
                timePerFrame: 0.1
            )
        )

        self.addChild(fireballNode)
        fireballNode.run(loopFireballFrames)
    }

    func createBackgroundAnimation() -> SKAction {
        let randomColourAnimationIDontKnow = SKAction.sequence(
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

        return randomColourAnimationIDontKnow
    }

}
// - MARK: Setup helpers
extension GameScene {

    private func setup() {
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesBegan start")

        print("GameScene:: touchesBegan finish")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded start")

        guard let firstTouch = touches.first else { return }
        let touchLocationInScene = firstTouch.location(in: self)

        print("GameScene:: touchesEnded finish", touchLocationInScene)
    }
}

// - MARK: Game timer
extension GameScene: TimeManagerDelegate {
    func timerTriggerPerSecond(currentTimeLeft: Int) {
        print("GameScene+TimeManagerDelegate:: timerTriggerPerSecond() \(currentTimeLeft)")
        
        spawnChickenRunner()

        self.spawnFireball(
            startPosition: self.spawnManager.getPositionScaled(
                sizeToScaleWithin: self.size,
                spawnPointProportion: CGPoint(x: 0.3, y: 0.4)
            ),
            destination: CGPoint(x: 0.3, y: 0.4), angle: 1.0
        )
    }

    func timerFinished() {
        print("GameScene+TimeManagerDelegate timerFinished()")
    }

}


