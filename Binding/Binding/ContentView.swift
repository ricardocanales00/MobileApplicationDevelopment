//
//  ContentView.swift
//  Binding
//
//  Created by Ricardo López Canales on 25/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var valorIntercambio : Bool = true
    
    var body: some View {
        VStack {
            Text("Mira cómo cambio de color, bro")
                .padding()
                .foregroundColor(valorIntercambio ? .green : .red)
            botton(text: "Picale aquí", intercambia: $valorIntercambio)
        }
    }
}

struct botton : View {
    
    var text : String
    @Binding var intercambia : Bool
    
    var body: some View{
        Button(action: {
            intercambia = !intercambia
        }) {
            Text(text)
        }
        .padding(20)
        .background(Color.blue)
        .foregroundColor(.white)
        .font(.title)
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
