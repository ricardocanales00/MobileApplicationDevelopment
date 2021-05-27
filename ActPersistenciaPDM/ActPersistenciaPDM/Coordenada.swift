//
//  Coordenada.swift
//  ActPersistenciaPDM
//
//  Created by Ricardo López Canales on 06/05/21.
//

import UIKit

class Coordenada: Codable {
    var num1 : Int
    var num2 : Int
    
    init(num1: Int, num2: Int) {
        self.num1 = num1
        self.num2 = num2
    }
}
