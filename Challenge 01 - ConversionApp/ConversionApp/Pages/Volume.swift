//
//  Volume.swift
//  ConversionApp
//
//  Created by Can Bi on 1.07.2021.
//  Updated by Can Bi on 27.01.2022.
//

import SwiftUI

struct Volume: View {
    let volume = ["Milimeters","Liters", "Cups", "Pints", "Gallons"]
    let units = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]

    var body: some View {
        ConversionPageView(selectionList: volume, units:units, typeName: "Volume")
    }
}
