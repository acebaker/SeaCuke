//
//  Cuke.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/17/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import Foundation
import AudioToolbox     // for vibration

// A protocol that the Cuke uses to inform its delegate of state change
protocol CukeDelegate {
    func getLucky(cuke: Cuke)
}

class Cuke: NSObject {
    
    var delegate: CukeDelegate?
    
    let excitementMax = 100
    var excitementCurrent = 0
    
    
    override init() {
        super.init()
    }
    
    func getExcited() -> Int {
        let newExcitement = Int(arc4random_uniform(10) + 1)
        excitementCurrent += newExcitement
        if excitementCurrent >= excitementMax {
            fullyExcited()
        }
        return excitementCurrent
    }
    
    func fullyExcited() {
        delegate!.getLucky(self)
        resetExcitement()
    }
    
    func resetExcitement() -> Int {
        excitementCurrent = 0
        print("excitementCurrent Reset = \(excitementCurrent)")
        return excitementCurrent
    }
    
    
}