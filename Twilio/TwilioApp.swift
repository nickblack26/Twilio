//
//  TwilioApp.swift
//  Twilio
//
//  Created by Nick Black on 6/14/24.
//

import SwiftUI
import SwiftData

@main
struct TwilioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Flow.self)
    }
}
