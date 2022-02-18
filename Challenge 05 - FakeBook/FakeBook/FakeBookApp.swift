//
//  FakeBookApp.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import SwiftUI

@main
struct FakeBookApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
