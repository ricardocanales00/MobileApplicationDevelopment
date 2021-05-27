//
//  ClaseReporte.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/2/21.
//

import UIKit

class Reporte : NSObject {
    var nombre : String = ""
    var lugar : String = ""
    var fecha : String = ""
    var descripcion : String = ""
    var imagen : UIImage?
    var key : String = ""
    var prioridad: Double = 0.0
    var latitud : Double = 0.0
    var longitud : Double = 0.0
    
    init (nombre: String, lugar: String, fecha: String, descripcion: String, prioridad: Double, imagen: UIImage!, key: String, latitud: Double, longitud: Double){
        self.nombre = nombre
        self.lugar = lugar
        self.fecha = fecha
        self.descripcion = descripcion
        self.prioridad = prioridad
        self.imagen = imagen
        self.key = key
        self.latitud = latitud
        self.longitud = longitud
    }
}
