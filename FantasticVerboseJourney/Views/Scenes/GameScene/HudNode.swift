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
    var textColor = SKColor(red: 0.63, green: 0.16, blue: 0.41, alpha: 1.0)
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
        let scaleFactor = size.height * 0.105 // size.height = 568 for iPhone SE (half of vert res 1136)
        
        highscore = defaults.integer(forKey: scoreKey)
        score = defaults.integer(forKey: currentScoreKey)
        
        scoreNode.text = "\(score)"
        scoreNode.fontSize = scaleFactor //60
        scoreNode.fontColor = textColor
        scoreNode.position = CGPoint(x: size.width / 2, y: size.height * 0.85)
        scoreNode.zPosition = 1
        
        addChild(scoreNode)
        
        highscoreNode.text = "BEST: \(highscore)"
        highscoreNode.fontSize = scaleFactor * 0.4//25
        highscoreNode.fontColor = textColor
        highscoreNode.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        highscoreNode.zPosition = 1
        
        addChild(highscoreNode)

    }
    
    public func addPoint() {
        scoreNode.run(SKAction.sequence([SKAction.scale(to: 1.2, duration: 0.05),
                                         SKAction.scale(to: 1, duration: 0.05)]))
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
            scoreNode.fontColor = textColor
        }
    }
    
    public func saveCurrentScore() {
        let defaults = UserDefaults.standard
        
        defaults.set(score, forKey: currentScoreKey)
    }
    
    private func updateScoreboard() {
        scoreNode.text = "\(score)"
        highscoreNode.text = "BEST: \(highscore)"
        print("score:", score)
        print("highscore:", highscore)
    }
    
}
