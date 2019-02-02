//
//  InjectionIiiHotReloadable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

@objc protocol InjectionIiiHotReloadable {
    #if DEBUG
    @objc func injected()
    #endif
}
