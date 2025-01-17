//
//  AnalyticsView.swift
//  SoccerBeat
//
//  Created by jose Yun on 10/22/23.
//

import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var healthInteractor: HealthInteractor
    
    var body: some View {
        VStack(spacing: nil) {
            VStack(alignment: .leading) {
                
                InformationButton(message: "최근 경기 데이터의 변화를 확인해 보세요.")
                
                HStack {
                    Text("추세")
                        .font(.mainTitleText)
                    Spacer()
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(ActivityEnum.allCases, id: \.self) { activityType in
                    NavigationLink {
                        switch activityType {
                        case .distance: DistanceChartView(workouts: healthInteractor.recentGames)
                        case .heartrate: BPMChartView(workouts: healthInteractor.recentGames)
                        case .speed: SpeedChartView(workouts: healthInteractor.recentGames)
                        case .sprint: SprintChartView(workouts: healthInteractor.recentGames)
                        }
                    } label: {
                        AnalyticsComponent(userWorkouts: healthInteractor.recent4Games, activityType: activityType)
                    }
                }
            }
        }
    }
}
#Preview {
    AnalyticsView()
        .environmentObject(HealthInteractor())
}
