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


    // - MARK: Load point
    override func sceneDidLoad() {
        // setup managers
        self.spawnManager = SpawnManager(spawnScene: self) // weak var ref like delegate
        self.timeManager = TimeManager(delegate: self, initialTimeSeconds: 5)

        setupPhysics()
        setupHud()

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

        // Rip data model. // Looks like no choice but to make a subclass for each type of mobsta lobsta monster
        let chickenPhysicsBody = MobFactory.getPhysicsBody(
            texture: chickenSprite.texture!,
            size: chickenSprite.size,
            contact: PhysicsCategory.fireball,
            category: PhysicsCategory.chicken,
            collision: PhysicsCategory.none
        )
        chickenSprite.physicsBody = chickenPhysicsBody

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
        /* PERF Stats
            Simulator 30FPS for 58 nodes and 50 draws with animated fireballs on screen by themselves.
         */
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
         design system. Artistic tuning easier than having a single object for
         each bespoke object without clear design system.
         */

        // -- FIXME: hmm reinit. can just preload this and store somewhere else in memory.
        let fireballAtlas = SKTextureAtlas(named: "fire")

        let fireballFrames: [SKTexture] = fireballAtlas.textureNames
            .map(
                {
                    fireballAtlas.textureNamed($0)
                }
        )

        let fireballNode = SKSpriteNode(texture: fireballFrames.first!)

        fireballNode.physicsBody = SKPhysicsBody(rectangleOf: fireballNode.size)
        fireballNode.physicsBody?.categoryBitMask = PhysicsCategory.fireball
//        fireballNode.physicsBody?.contactTestBitMask = PhysicsCategory.chicken

        fireballNode.position = startPosition
        let loopFireballFrames = SKAction.repeatForever(
            SKAction.animate(
                with: fireballFrames,
                timePerFrame: 0.1
            )
        )

        // Spawn
        self.addChild(fireballNode)
        // Animate frames
        fireballNode.run(loopFireballFrames)

        // Shoot

        // Shoot move
        // 0.5 seconds...
        let fireballMoveToDest = SKAction.move(to: destination, duration: 0.5)
        fireballNode.run(fireballMoveToDest)

        // Shoot angle


        // Hahah trig
        // Quad1 angle
        // Quad2 Pi 180 rads - angle zzz
        // Quad3 Pi + anglezzz
        // Quad 4 2Pi - Anglezzz
        // - TEST angle rotation radians
        let angle1 = tanh(size.height / size.width) // e.g. angle to corner by aspect ratio .9445

        fireballNode.zRotation = angle1 + 2 * CGFloat.pi
//        let angle3 =
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

    private func setupPhysics() {
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

    }
    private func setupHud() {
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
        let fireballOrientationRadians = getCornerOrientationAngle(touchPositionForQuadrantCalc: touches.first!)

        // Testing - DEBUG: test
        spawnFireball(
            startPosition: spawnManager.getPositionScaled(
                sizeToScaleWithin: self.size,
                spawnPointProportion: CGPoint(
                    x: 0.4,
                    y: 0.1
                )
            ),
            destination: CGPoint(
                x: 0.7,
                y: 0.8
            ),
            angle: fireballOrientationRadians
        )
        print("GameScene:: touchesBegan finish")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded start")

        guard let firstTouch = touches.first else { return }
        let touchLocationInScene = firstTouch.location(in: self)

        print("GameScene:: touchesEnded finish", touchLocationInScene)
    }
}

// - MARK: Orientation four corners angle
extension GameScene {

    // Could just keep this pre-caclulated preloaded.
    // Angle to rotate towards the four corners if touch in four quadrants.
    // hmm snappy. Different ways of doing this but depends on UX look and feel.
    fileprivate func cornerAnglesForQuadrantRanges(
        _ scaledTouchLocation: CGPoint,
        _ positiveXRange: Range<CGFloat>,
        _ positiveYRange: Range<CGFloat>,
        _ negativeXRange: Range<CGFloat>,
        _ negativeYRange: Range<CGFloat>
    ) -> CGFloat
    {

        // swiftlint:disable identifier_name
        // Cartesian trig stuff based on formulae... SATC
        // Corresponds to aspect ratio... Trianglezzz vs 1 / 1
        // 0 to 2π radians 360
        let thetaAngle = tanh(self.size.height / self.size.width)
        let π = CGFloat.pi

        // -- FIXME: Function would be more readable now that it is fleshed out with more verbose lines.
        switch (scaledTouchLocation.x, scaledTouchLocation.y) {

        case(positiveXRange, positiveYRange):
            // Quadrant I Top-right
            let angleRadiansTowardsCorner = thetaAngle
            print("Quad-I", angleRadiansTowardsCorner)
            return angleRadiansTowardsCorner

        case(negativeXRange, positiveYRange):
            // Quadrant II Top-left
            let angleRadiansTowardsCorner = π - thetaAngle
            print("Quad-II", angleRadiansTowardsCorner)
            return angleRadiansTowardsCorner

        case(negativeXRange, negativeYRange):
            // Quadrant III Bottom-left
            let angleRadiansTowardsCorner = π + thetaAngle
            print("Quad-III", angleRadiansTowardsCorner)
            return angleRadiansTowardsCorner

        case(positiveXRange, negativeYRange):
            // Quadrant IV Bottom-right
            let angleRadiansTowardsCorner = 2 * π - thetaAngle
            print("Quad-IV", angleRadiansTowardsCorner)
            return angleRadiansTowardsCorner

        case (_, _):
            print("_, _ Quad-9001 no quads")
            return thetaAngle
        }

    }

    func getCornerOrientationAngle(
        touchPositionForQuadrantCalc touchLocation: UITouch
    ) -> CGFloat {
        let midWidth = size.width / 2
        let midHeight = size.height / 2

        let scaledTouchLocation = touchLocation.location(in: self)
        print(touchLocation, scaledTouchLocation)

        // x and y ranges for each of the four quadrants.
        // Cartesian coordinate system quadrants?
        // In relation to 0.5, 0.5 instead of 0, 0
        // Quadrant I   +x, +y; Quadrant II -x, +y;
        // Quadrant III -x, -y; Quadrant IV +x, -y;
        // However, using anchorpoint 0.5, 0.5 as origin instead of origin 0, 0

        let positiveXRange = midWidth..<size.width
        let negativeXRange = 0..<midWidth
        let positiveYRange = midHeight..<size.height
        let negativeYRange = 0..<midHeight

//        // Pre-defined quadrant var didn't work
//        let topRightQuadrantI: (Range<CGFloat>, Range<CGFloat>) = (positiveXRange, positiveYRange)
//        let topLeftQuadrantII = (negativeXRange, positiveYRange)
//        let bottomLeftQuadrantIII = (negativeXRange, negativeYRange)
//        let bottomRightQuadrantIV = (positiveXRange, negativeYRange)

        // Could use the same 4 positions enum with preloaded angles instead of inline closure
        let orientAngle: CGFloat = cornerAnglesForQuadrantRanges(scaledTouchLocation, positiveXRange, positiveYRange, negativeXRange, negativeYRange)

        return orientAngle
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


