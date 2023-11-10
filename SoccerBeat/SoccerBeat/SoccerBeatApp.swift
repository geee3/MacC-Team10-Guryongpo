//
//  SoccerBeatApp.swift
//  SoccerBeat
//
//  Created by daaan on 10/21/23.
//

import SwiftUI

@main
struct SoccerBeatApp: App {
    @StateObject var soundManager: SoundManager = SoundManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(soundManager)
        }
    }
}
