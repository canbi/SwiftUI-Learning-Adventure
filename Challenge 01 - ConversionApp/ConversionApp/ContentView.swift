//
//  ContentView.swift
//  ConversionApp
//
//  Created by Can Bi on 1.07.2021.
//  Updated by Can Bi on 27.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Temperature()
             .tabItem {
                Image(systemName: "thermometer.sun.fill")
                Text("Temperature")
             }
            
            Length()
             .tabItem {
                Image(systemName: "ruler.fill")
                Text("Length")
             }
            
            Time()
             .tabItem {
                Image(systemName: "clock.fill")
                Text("Time")
             }
            
            Volume()
             .tabItem {
                Image(systemName: "rectangle.roundedbottom.fill")
                Text("Volume")
             }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
