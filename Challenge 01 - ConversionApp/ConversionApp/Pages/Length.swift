//
//  Length.swift
//  ConversionApp
//
//  Created by Can Bi on 1.07.2021.
//  Updated by Can Bi on 27.01.2022.
//

import SwiftUI

struct Length: View {
    let length = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let units = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]

    var body: some View {
        ConversionPageView(selectionList: length, units:units, typeName: "Length")
    }
}
