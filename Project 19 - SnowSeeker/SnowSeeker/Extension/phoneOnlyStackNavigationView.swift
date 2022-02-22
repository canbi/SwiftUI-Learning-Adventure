//
//  phoneOnlyStackNavigationView.swift
//  SnowSeeker
//
//  Created by Can Bi on 22.02.2022.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
