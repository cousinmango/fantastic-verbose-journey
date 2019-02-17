//
//  GameScene+HotReloadable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 11/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//
import Foundation

extension GameScene {

    #if DEBUG
    @objc func injected() {
        print("GameScene:: injected() injecting")
        // self.removeAllChildren()
        // -- TODO: Add remove scene child nodes as well to refresh SpriteKit scenes.
        let homeMenuScene = HomeMenuScene(size: size)
        self.view?.presentScene(homeMenuScene)
        print("GameScene:: viewDidLoad activated")
    }
    #endif

}
