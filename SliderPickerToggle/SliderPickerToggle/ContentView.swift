//
//  ContentView.swift
//  SliderPickerToggle
//
//  Created by Ricardo López Canales on 23/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var sliderValue : Float = 0.5
    @State var pickerValue : Int = 1
    @State var toggleValue : Bool = true
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
                VStack {
                    Slider(value: $sliderValue)
                    Text(String(sliderValue))
                        .padding()
                }
                .background(Color.orange)
                Spacer()
                
                
                
                
                VStack{
                    Picker(selection: $pickerValue, label: Text("Posición")) {
                        Text("Izquierda").tag(1)
                        Text("Derecha").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    GeometryReader{ geo in
                        Text("🥳")
                            .font(.largeTitle)
                            .position(x: pickerValue == 1 ? geo.size.width * 0.1 : geo.size.width * 0.9, y: geo.size.height * 0.4)
                            .animation(.easeIn(duration: 1))
                    }
                }
                .background(Color.green)
                .frame(width: geo.size.width, height: geo.size.height * 0.2)
                
                
                
                Spacer()
                VStack{
                    Toggle(isOn: $toggleValue) {
                        Text("Color de fondo")
                            .foregroundColor(toggleValue == true ? .yellow : .blue)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .background(toggleValue == true ? Color.black : Color.gray)
            .animation(.easeInOut(duration: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
