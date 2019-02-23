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

        setupSpawn()
    }
    override func didMove(to view: SKView) {

    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }

}

// - MARK: Spawn
extension GameScene {
    func setupSpawn() {
        self.spawnManager = SpawnManager(spawnScene: self) // weak var ref like delegate
        
//        let scaleFactor = size.height * 0.25
        let chickenMob = MobFactory.createChicken(
            initAnimation: nil
        )
        let chick2 = chickenMob
        spawnManager.spawn(
            spawnMob: chickenMob,
            possibleSpawnPositions: [
                SpawnPositionProportion.northEastern
            ]
        )
        spawnManager.spawn(
            spawnMob: chickenMob,
            possibleSpawnPositions: [
                SpawnPositionProportion.northWestern
            ]
        )

        spawnManager.spawn(
            spawnMob: chick2,
            possibleSpawnPositions: [
                SpawnPositionProportion.northWestern
            ]
        )

        let testPositions = [
            SpawnPositionProportion.southEastern,
            SpawnPositionProportion.southWestern
        ]
        spawnManager.spawn(
            spawnMob: MobFactory.createChicken(initAnimation: SKAction.moveTo(x: 99, duration: 2)),
            possibleSpawnPositions: testPositions
        )
        // - FIXME:  using spawnmanager to spawn using the same instance of Mob causes a crash appdelegate first load // ref error dunno
        
        /*
             2019-02-23 07:57:10.476884+1000 FantasticVerboseJourney[5659:149226] libMobileGestalt MobileGestalt.c:890: MGIsDeviceOneOfType is not supported on this platform.
             Injection connected, watching /Users/xcodeserver/Projects/cousinmango/fantastic-verbose-journey/**
             GameViewController:: viewDidLoad()
             2019-02-23 07:57:10.672969+1000 FantasticVerboseJourney[5659:149226] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Attemped to add a SKNode which already has a parent: <SKSpriteNode> name:'(null)' texture:[<SKTexture> '<data>' (400 x 400)] position:{0.80000001192092896, 0.20000000298023224} scale:{1.00, 1.00} size:{200, 200} anchor:{0.5, 0.5} rotation:0.00'
             *** First throw call stack:
             (
             0   CoreFoundation                      0x000000010cc451bb __exceptionPreprocess + 331
             1   libobjc.A.dylib                     0x000000010c1eb735 objc_exception_throw + 48
             2   CoreFoundation                      0x000000010cc45015 +[NSException raise:format:] + 197
             3   SpriteKit                           0x000000010d0f8ad8 -[SKNode insertChild:atIndex:] + 162
             4   SpriteKit                           0x000000010d0f8a13 -[SKNode addChild:] + 68
             5   FantasticVerboseJourney             0x000000010b2e2d93 $S23FantasticVerboseJourney12SpawnManagerC5spawn0F3Mob08possibleD9PositionsyAA0G0V_SaySo7CGPointVGtF + 819
             6   FantasticVerboseJourney             0x000000010b2e690f $S23FantasticVerboseJourney9GameSceneC10setupSpawnyyF + 1327
             7   FantasticVerboseJourney             0x000000010b2e63d9 $S23FantasticVerboseJourney9GameSceneC12sceneDidLoadyyF + 25
             8   FantasticVerboseJourney             0x000000010b2e69f4 $S23FantasticVerboseJourney9GameSceneC12sceneDidLoadyyFTo + 36
             9   SpriteKit                           0x000000010d0b98cb -[SKScene initWithSize:] + 791
             10  FantasticVerboseJourney             0x000000010b2e617b $S23FantasticVerboseJourney9GameSceneC4sizeACSo6CGSizeV_tcfc + 219
             11  FantasticVerboseJourney             0x000000010b2e61c3 $S23FantasticVerboseJourney9GameSceneC4sizeACSo6CGSizeV_tcfcTo + 19
             12  SpriteKit                           0x000000010d0b95b2 -[SKScene init] + 28
             13  FantasticVerboseJourney             0x000000010b2e6007 $S23FantasticVerboseJourney9GameSceneCACycfc + 183
             14  FantasticVerboseJourney             0x000000010b2e6043 $S23FantasticVerboseJourney9GameSceneCACycfcTo + 19
             15  FantasticVerboseJourney             0x000000010b2e5eec $S23FantasticVerboseJourney9GameSceneCACycfC + 44
             16  FantasticVerboseJourney             0x000000010b2edec6 $S23FantasticVerboseJourney13HomeMenuSceneC4sizeACSo6CGSizeV_tcfc + 134
             17  FantasticVerboseJourney             0x000000010b2ee153 $S23FantasticVerboseJourney13HomeMenuSceneC4sizeACSo6CGSizeV_tcfcTo + 19
             18  FantasticVerboseJourney             0x000000010b2ede30 $S23FantasticVerboseJourney13HomeMenuSceneC4sizeACSo6CGSizeV_tcfC + 64
             19  FantasticVerboseJourney             0x000000010b2e3674 $S23FantasticVerboseJourney18GameViewControllerC11viewDidLoadyyF + 916
             20  FantasticVerboseJourney             0x000000010b2e3944 $S23FantasticVerboseJourney18GameViewControllerC11viewDidLoadyyFTo + 36
             21  UIKitCore                           0x0000000118e1f4e1 -[UIViewController loadViewIfRequired] + 1186
             22  UIKitCore                           0x0000000118e1f940 -[UIViewController view] + 27
             23  UIKitCore                           0x0000000119476c53 -[UIWindow addRootViewControllerViewIfPossible] + 122
             24  UIKitCore                           0x000000011947736e -[UIWindow _setHidden:forced:] + 294
             25  UIKitCore                           0x000000011948a5c0 -[UIWindow makeKeyAndVisible] + 42
             26  UIKitCore                           0x0000000119437833 -[UIApplication _callInitializationDelegatesForMainScene:transitionContext:] + 4595
             27  UIKitCore                           0x000000011943cc2f -[UIApplication _runWithMainScene:transitionContext:completion:] + 1623
             28  UIKitCore                           0x0000000118c5b4e9 __111-[__UICanvasLifecycleMonitor_Compatability _scheduleFirstCommitForScene:transition:firstActivation:completion:]_block_invoke + 866
             29  UIKitCore                           0x0000000118c6429c +[_UICanvas _enqueuePostSettingUpdateTransactionBlock:] + 153
             30  UIKitCore                           0x0000000118c5b126 -[__UICanvasLifecycleMonitor_Compatability _scheduleFirstCommitForScene:transition:firstActivation:completion:] + 233
             31  UIKitCore                           0x0000000118c5bae0 -[__UICanvasLifecycleMonitor_Compatability activateEventsOnly:withContext:completion:] + 1085
             32  UIKitCore                           0x0000000118c59cb5 __82-[_UIApplicationCanvas _transitionLifecycleStateWithTransitionContext:completion:]_block_invoke + 795
             33  UIKitCore                           0x0000000118c5995f -[_UIApplicationCanvas _transitionLifecycleStateWithTransitionContext:completion:] + 435
             34  UIKitCore                           0x0000000118c5ea90 __125-[_UICanvasLifecycleSettingsDiffAction performActionsForCanvas:withUpdatedScene:settingsDiff:fromSettings:transitionContext:]_block_invoke + 584
             35  UIKitCore                           0x0000000118c5f80e _performActionsWithDelayForTransitionContext + 100
             36  UIKitCore                           0x0000000118c5e7ef -[_UICanvasLifecycleSettingsDiffAction performActionsForCanvas:withUpdatedScene:settingsDiff:fromSettings:transitionContext:] + 221
             37  UIKitCore                           0x0000000118c6393a -[_UICanvas scene:didUpdateWithDiff:transitionContext:completion:] + 392
             38  UIKitCore                           0x000000011943b44e -[UIApplication workspace:didCreateScene:withTransitionContext:completion:] + 515
             39  UIKitCore                           0x0000000118fdfd09 -[UIApplicationSceneClientAgent scene:didInitializeWithEvent:completion:] + 357
             40  FrontBoardServices                  0x00000001185f02da -[FBSSceneImpl _didCreateWithTransitionContext:completion:] + 448
             41  FrontBoardServices                  0x00000001185fb443 __56-[FBSWorkspace client:handleCreateScene:withCompletion:]_block_invoke_2 + 271
             42  FrontBoardServices                  0x00000001185fab3a __40-[FBSWorkspace _performDelegateCallOut:]_block_invoke + 53
             43  libdispatch.dylib                   0x000000010f143602 _dispatch_client_callout + 8
             44  libdispatch.dylib                   0x000000010f146b78 _dispatch_block_invoke_direct + 301
             45  FrontBoardServices                  0x000000011862fba8 __FBSSERIALQUEUE_IS_CALLING_OUT_TO_A_BLOCK__ + 30
             46  FrontBoardServices                  0x000000011862f860 -[FBSSerialQueue _performNext] + 457
             47  FrontBoardServices                  0x000000011862fe40 -[FBSSerialQueue _performNextFromRunLoopSource] + 45
             48  CoreFoundation                      0x000000010cbaa721 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
             49  CoreFoundation                      0x000000010cba9f93 __CFRunLoopDoSources0 + 243
             50  CoreFoundation                      0x000000010cba463f __CFRunLoopRun + 1263
             51  CoreFoundation                      0x000000010cba3e11 CFRunLoopRunSpecific + 625
             52  GraphicsServices                    0x00000001122a41dd GSEventRunModal + 62
             53  UIKitCore                           0x000000011943e81d UIApplicationMain + 140
             54  FantasticVerboseJourney             0x000000010b2dccb7 main + 71
             55  libdyld.dylib                       0x000000010f1b9575 start + 1
             )
             libc++abi.dylib: terminating with uncaught exception of type NSException
         
         */ // */ // */ // log had grop wildcards slash oops escape // */ // */ // */
        
    }
}

extension GameScene {

    fileprivate func startMusic() {
        guard let musicUrl = SoundAssetUrl.gameMusicUrl else { return }

        let gameMusic = SKAudioNode(url: musicUrl)
        addChild(gameMusic)
    }

    
    func spawnFireball(
        position: CGPoint,
        destination: CGPoint,
        angle: CGFloat
        ) {
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
