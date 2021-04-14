//
//  Clima.swift
//  Hw5.Protocols
//
//  Created by Ricardo López Canales on 9/04/21.
//

import UIKit

class Clima: NSObject {
    var nombre : String
    var grados : Int
    var foto : UIImage!
    
    init(nombre: String, grados: Int, foto: UIImage!) {
        self.nombre = nombre
        self.grados = grados
        self.foto = foto
    }

}
