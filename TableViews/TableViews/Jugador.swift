//
//  Jugador.swift
//  TableViews
//
//  Created by Ricardo López Canales on 06/04/21.
//

import UIKit

class Jugador: NSObject {
    var nombre : String = ""
    var puntos : Int = 0
    var foto : UIImage!
    
    init(nombre : String, puntos : Int, foto : UIImage!) {
        self.nombre = nombre
        self.puntos = puntos
        self.foto = foto
    }

}
