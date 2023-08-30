//
//  PersistenceController.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/30/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "FavoritesJokes")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
