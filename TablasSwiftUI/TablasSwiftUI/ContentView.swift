//
//  ContentView.swift
//  TablasSwiftUI
//
//  Created by Ricardo Lรณpez Canales on 25/03/21.
//

import SwiftUI

struct ContentView: View {
    
    var listaDeportes = [
        Deporte(nombre: "Mexico", imagen: "๐ฒ๐ฝ"),
        Deporte(nombre: "America", imagen: "๐บ๐ธ"),
        Deporte(nombre: "Spain", imagen: "๐ช๐ธ"),
        Deporte(nombre: "UK", imagen: "๐ฌ๐ง"),
        Deporte(nombre: "India", imagen: "๐ฎ๐ณ")
    ]
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach (listaDeportes, id: \.self){ deporte in
                    NavigationLink(
                        destination: DetalleDeporte(titulo: deporte.nombre, imagen: deporte.imagen),
                        label: {
                            celdaDeporte(titulo: deporte.nombre, imagen: deporte.imagen)
                        })
                }
            }
            .navigationTitle("Countries list")
            .font(.largeTitle)
        }
    }
}

struct celdaDeporte : View {
    var titulo : String
    var imagen : String
    
    var body : some View {
        HStack{
            Text(imagen)
                .font(.system(size: 60))
            Spacer()
            Text(titulo)
                .font(.title)
                .padding()
        }
        .background(Color.gray)
        .cornerRadius(10)
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
