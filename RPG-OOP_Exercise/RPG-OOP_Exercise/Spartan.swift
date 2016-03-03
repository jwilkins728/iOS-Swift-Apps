//
//  Spartan.swift
//  RPG-OOP_Exercise
//
//  Created by Ralph Cachero on 1/3/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import Foundation

class Spartan: Character {
    private var _name = "Spartan"
    
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init(name: String, hp: Int, attackPwr: Int) {
        self.init(startingHp: hp, attackPwr: attackPwr)
        
        _name = name
    }
}