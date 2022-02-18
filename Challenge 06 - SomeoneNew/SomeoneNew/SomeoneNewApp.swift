//
//  SomeoneNewApp.swift
//  SomeoneNew
//
//  Created by Can Bi on 15.02.2022.
//

import SwiftUI

@main
struct SomeoneNewApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var localFileManager = LocalFileManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(localFileManager)
        }
    }
}
