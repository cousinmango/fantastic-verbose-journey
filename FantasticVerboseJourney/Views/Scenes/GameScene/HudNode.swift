//
//  HudNode.swift
//  FantasticVerboseJourney
//
//  Created by Lai Phong Tran on 31/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import Foundation
import SpriteKit

class HudNode : SKNode {
    private let scoreKey = "DUCKMAN_HIGHSCORE"
    private let currentScoreKey = "CURRENT_SCORE"
    private let scoreNode = SKLabelNode(fontNamed: "DIN Alternate")
    private let highscoreNode = SKLabelNode(fontNamed: "DIN Alternate")
    private(set) var score : Int = 0
    private var highscore : Int = 0
    private var showingHighScore = false
    
    //Setup hud here
    public func setup(size: CGSize) {
        let defaults = UserDefaults.standard
        
        highscore = defaults.integer(forKey: scoreKey)
        score = defaults.integer(forKey: currentScoreKey)
        
        scoreNode.text = "\(score)"
        scoreNode.fontSize = 70
        scoreNode.position = CGPoint(x: size.width / 2, y: size.height * 0.85)
        scoreNode.zPosition = 1
        
        addChild(scoreNode)
        
        highscoreNode.text = "\(highscore)"
        highscoreNode.fontSize = 30
        highscoreNode.fontColor = SKColor.yellow
        highscoreNode.position = CGPoint(x: size.width * 0.2, y: size.height * 0.85)
        highscoreNode.zPosition = 1
        
        addChild(highscoreNode)

    }
    
    public func addPoint() {

        score += 1

        if score > highscore {
            highscore = score
            
            let defaults = UserDefaults.standard
            
            defaults.set(score, forKey: scoreKey)
            
            if !showingHighScore {
                showingHighScore = true
                
                scoreNode.run(SKAction.scale(to: 1.3, duration: 0.25))
                scoreNode.fontColor = SKColor.yellow
            }
        }
        updateScoreboard()
    }
    
    public func resetPoints() {
        print("resetPoints")
        score = 0
        
        updateScoreboard()
        
        if showingHighScore {
            showingHighScore = false
            
            scoreNode.run(SKAction.scale(to: 1.0, duration: 0.25))
            scoreNode.fontColor = SKColor.white
        }
    }
    
    public func saveCurrentScore() {
        let defaults = UserDefaults.standard
        
        defaults.set(score, forKey: currentScoreKey)
    }
    
    private func updateScoreboard() {
        scoreNode.text = "\(score)"
        highscoreNode.text = "\(highscore)"
        print("score:", score)
        print("highscore:", highscore)
    }
    
}
