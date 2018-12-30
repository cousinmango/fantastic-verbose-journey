//
//  GameViewController.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController:: viewDidLoad()")

        // Load ref to storyboard view... lame instead of programmatic
        guard let skView = self.view as! SKView? else { return }
        // Load main game scene. - TODO: Replace with home menu.
        guard let gameScene = GameScene(fileNamed: "GameScene") else { return }

        gameScene.scaleMode = .aspectFit
        gameScene.view?.setPerformanceOptimisation()
        gameScene.view?.setShowDebug()

        skView.presentScene(
            gameScene,
            transition: SKTransition.reveal(with: .down, duration: 1.0)
        )

    }
}

// - MARK: - UIViewController lifecycle hooks config
extension GameViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


