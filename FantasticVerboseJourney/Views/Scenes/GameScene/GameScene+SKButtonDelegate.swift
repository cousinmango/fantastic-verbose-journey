//
//  GameScene+SKButtonDelegate.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 17/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

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
