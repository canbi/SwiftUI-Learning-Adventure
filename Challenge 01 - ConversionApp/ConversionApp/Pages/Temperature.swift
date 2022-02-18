//
//  Temperature.swift
//  ConversionApp
//
//  Created by Can Bi on 1.07.2021.
//  Updated by Can Bi on 27.01.2022.
//

import SwiftUI

struct Temperature: View {
    let temperature = ["Kelvin","Fahrenheit","Celsius"]
    let units = [UnitTemperature.kelvin, UnitTemperature.fahrenheit, UnitTemperature.celsius]

    var body: some View {
        ConversionPageView(selectionList: temperature, units:units, typeName: "Temperature")
    }
}
