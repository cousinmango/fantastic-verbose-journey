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
        
        
        // Load ref to storyboard view... lame vs programmatic
        guard let skView = self.view as! SKView? else { return }
        skView.showsNodeCount = false

        let homeMenuScene = HomeMenuScene(size: view.bounds.size)
        // homeMenuScene.scaleMode = .aspectFit
        // Default blank .sks file replicate programmatically with dimension W: 750 H: 1334
        // Anchor point 0.5, 0.5
        homeMenuScene.view?.setPerformanceOptimisation()
        homeMenuScene.view?.setShowDebug()

        skView.presentScene(
            homeMenuScene,
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


