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
    var key : String = ""
    
    init (nombre: String, tipo: String, usuario: String, fecha: String, descripcion: String, key : String ){
        self.nombre = nombre
        self.tipo = tipo
        self.usuario = usuario
        self.fecha = fecha
        self.descripcion = descripcion
        self.key = key
    }
}

class Usuario: NSObject {
    var nombre : String?
    var admin : Bool
    var cargo : String?
    var correo : String?
    var telefono : String?
    var verificacion : Bool
    var id: String?
    
    init(nombre: String, cargo: String, correo: String, telefono: String, admin: Bool, verificacion : Bool, id: String){
        self.admin = admin
        self.cargo = cargo
        self.correo = correo
        self.telefono = telefono
        self.verificacion = verificacion
        self.nombre = nombre
        self.id = id
    }
    

}
