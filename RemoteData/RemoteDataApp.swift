//
//  RemoteDataApp.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/29/23.
//

import SwiftUI

@main
struct RemoteDataApp: App {
    @StateObject private var manager: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
