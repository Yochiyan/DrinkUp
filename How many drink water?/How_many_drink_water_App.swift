//
//  How_many_drink_water_App.swift
//  How many drink water?
//
//  Created by よっちゃん on 2025/09/18.
//

import SwiftUI
import SwiftData

@main
struct WaterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Bottle.self, DrinkRecord.self]) // 2モデル対応
    }
}
