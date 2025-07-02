//
//  FunkyMelonApp.swift
//  FunkyMelon
//
//  Created by Stephen del Rosario on 6/30/25.
//

import SwiftUI
import SwiftData

@main
struct FunkyMelonApp: App {
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .modelContainer(sharedModelContainer)
    }
}
