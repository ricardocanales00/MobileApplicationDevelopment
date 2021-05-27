//
//  Coordenada.swift
//  ClassActivityPersistencia
//
//  Created by Ricardo López Canales on 16/04/21.
//

import UIKit

class Coordenada: Codable {
    var Numero1 : Int = 0
    var Numero2 : Int = 0
    
    init(Numero1 : Int, Numero2 : Int) {
        self.Numero1 = Numero1
        self.Numero2 = Numero2
        
    }

}
