//
//  Time.swift
//  ConversionApp
//
//  Created by Can Bi on 1.07.2021.
//  Updated by Can Bi on 27.01.2022.
//

import SwiftUI

struct Time: View {
    let time = ["Miliseconds","Seconds", "Minutes", "Hours"]
    let units = [UnitDuration.milliseconds, UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours,]

    var body: some View {
        ConversionPageView(selectionList: time, units:units, typeName: "Time")
    }
}
