//
//  App.swift
//  TableViews
//
//  Created by Ricardo López Canales on 06/04/21.
//

import UIKit

class App: NSObject {
    var nombre : String = ""
    var foto : UIImage!
    
    init(nombre : String, foto : UIImage!) {
        self.nombre = nombre
        self.foto = foto
    }
}
