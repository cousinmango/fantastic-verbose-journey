//
//  UIViewController+InjectionIiiHotReloadable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    #if DEBUG
    @objc func injected() {
        print("UIViewController:: injected() injecting")
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        if let sublayers = self.view.layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
        // -- TODO: Add remove scene child nodes as well to refresh SpriteKit scenes.
        viewDidLoad()
        print("UIViewController:: viewDidLoad activated")
    }
    #endif
}
