//
//  ContentView.swift
//  SoccerBeat
//
//  Created by daaan on 10/21/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @StateObject var healthInteractor = HealthInteractor.shared
    var body: some View {
        ScrollView {
            ZStack {
                Image("BackgroundPattern")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 0)
                
                VStack {
                    MyCardView()
                    
                    Spacer()
                        .frame(height: 114)
                    
                    
                    MatchRecapView()
                    
                    Spacer()
                        .frame(height: 60)
                    
                    AnalyticsView()
                    
                    Spacer()
                        .frame(height: 60)
                    
                }
            }
        }.task {
            await healthInteractor.fetchAllData()
            print("stop ..")
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
