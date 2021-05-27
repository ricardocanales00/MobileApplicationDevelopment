//
//  ClaseTarea.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/2/21.
//

import UIKit

class Tarea : NSObject {
    var nombre: String = ""
    var tipo: String = ""
    var usuario: String = ""
    var fecha : String = ""
    var descripcion: String = ""
    
    init (nombre: String, tipo: String, usuario: String, fecha: String, descripcion: String){
        self.nombre = nombre
        self.tipo = tipo
        self.usuario = usuario
        self.fecha = fecha
        self.descripcion = descripcion
    }
}
