//
//  PauseScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import SpriteKit.SKScene

class PauseScene: SKScene {
    var returnScene: SKScene? // to return to after un-pause... Should replace with delegate pattern?

    override init() {
        super.init()
    }

    override init(size: CGSize) {
        super.init(size: size)
    }

    init(returnScene: SKScene) {
        super.init()
        self.returnScene = returnScene
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        print("PauseScene:: didMove \(view)")
        let backgroundSquare = SKSpriteNode(
            texture: nil,
            color: .orange,
            size: CGSize(width: 500, height: 500)
        )

        self.addChild(backgroundSquare)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("PauseScene:: touchesEnded", touches.first)
        self.view?.presentScene(self.returnScene)
    }
}
