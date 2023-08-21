//
//  SeniorIceCreamApp.swift
//  SeniorIceCream
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

@main
struct SeniorIceCreamApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
