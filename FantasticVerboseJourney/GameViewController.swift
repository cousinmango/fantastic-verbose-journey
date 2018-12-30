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
        
        // Load main game scene. - TODO: Replace with home menu.
        guard let gameScene = GameScene(fileNamed: "GameScene") else {
            return
        }
        gameScene.scaleMode = .aspectFit
        gameScene.view?.setShowDebug()
        gameScene.view?.setPerformanceOptimisation()
        
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
