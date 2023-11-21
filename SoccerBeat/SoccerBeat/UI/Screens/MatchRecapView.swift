//
//  MatchRecapView.swift
//  SoccerBeat
//
//  Created by Hyungmin Kim on 2023/10/22.
//

import SwiftUI

struct MatchRecapView: View {
    
    @EnvironmentObject var healthInteractor: HealthInteractor
    @Binding var userWorkouts: [WorkoutData]
    @Binding var averageData: WorkoutAverageData
    @Binding var maximumData: WorkoutAverageData
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("Hello, Isaac")
                    Text("Your archive")
                }
                .foregroundStyle(
                    .linearGradient(colors: [.hotpink, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .font(.custom("SFProText-HeavyItalic", size: 36))
                .kerning(-1.5)
                .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 30)
            
            Spacer()
                .frame(height: 60)
            
            HStack {
                Text("최근 경기 기록")
                    .font(.custom("NotoSansDisplay-BlackItalic", size: 24))
                Spacer()
            }
            .padding(.horizontal)
            VStack {
                ForEach(userWorkouts ?? [], id: \.self) { workout in
                    NavigationLink {
                        MatchDetailView(averageData: $averageData, maximumData: $maximumData, workoutData: workout)
                    } label: {
                        MatchListItemView(workoutData: workout, averageData: $averageData)
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MatchListItemView: View {
    let workoutData: WorkoutData
    @State private var currentLocation = "--'--"
    @Binding var averageData: WorkoutAverageData
    
    var body: some View {
        ZStack {
            LightRectangleView(alpha: 0.2, color: .white, radius: 15)
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(workoutData.matchBadge.indices, id: \.self) { index in
                        if let badgeName = BadgeImageDictionary[index][workoutData.matchBadge[index]] {
                            if badgeName.isEmpty {
                                EmptyView()
                            } else {
                                Image(badgeName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 36)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .offset(CGSize(width: 15.0, height: -20.0))
                    Spacer()
                }
                Spacer()
            }
            
            HStack {
                Spacer ()
                
                let averageLevel = dataConverter(totalDistance: averageData.totalDistance,
                                           maxHeartRate: averageData.maxHeartRate,
                                           maxVelocity: averageData.maxVelocity,
                                           maxAcceleration: averageData.maxAcceleration,
                                           sprintCount: averageData.sprintCount,
                                           minHeartRate: averageData.minHeartRate,
                                           rangeHeartRate: averageData.rangeHeartRate,
                                           totalMatchTime: averageData.totalMatchTime)
                let average = [(averageLevel["totalDistance"] ?? 1.0) * 0.15 + (averageLevel["maxHeartRate"] ?? 1.0) * 0.35,
                               (averageLevel["maxVelocity"] ?? 1.0) * 0.3 + (averageLevel["maxAcceleration"] ?? 1.0) * 0.2,
                               (averageLevel["maxVelocity"] ?? 1.0) * 0.25 + (averageLevel["sprintCount"] ?? 1.0) * 0.125 + (averageLevel["maxHeartRate"] ?? 1.0) * 0.125,
                               (averageLevel["maxAcceleration"] ?? 1.0) * 0.4 + (averageLevel["minHeartRate"] ?? 1.0) * 0.1,
                               (averageLevel["totalDistance"] ?? 1.0) * 0.15 + (averageLevel["rangeHeartRate"] ?? 1.0) * 0.15 + (averageLevel["totalMatchTime"] ?? 1.0) * 0.2,
                               (averageLevel["totalDistance"] ?? 1.0) * 0.3 + (averageLevel["sprintCount"] ?? 1.0) * 0.1 + (averageLevel["maxHeartRate"] ?? 1.0) * 0.1]
                
                let rawTime = workoutData.time
                let separatedTime = rawTime.components(separatedBy: ":")
                let separatedMinutes = separatedTime[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let separatedSeconds = separatedTime[1].trimmingCharacters(in: .whitespacesAndNewlines)
                let recentLevel = dataConverter(totalDistance: workoutData.distance,
                                                maxHeartRate: workoutData.maxHeartRate,
                                                maxVelocity: workoutData.velocity,
                                                maxAcceleration: workoutData.acceleration,
                                                sprintCount: workoutData.sprint,
                                                minHeartRate: workoutData.minHeartRate,
                                                rangeHeartRate: workoutData.maxHeartRate - workoutData.minHeartRate,
                                                totalMatchTime: Int(separatedMinutes)! * 60 + Int(separatedSeconds)!)
                let recent = [(recentLevel["totalDistance"] ?? 1.0) * 0.15 + (recentLevel["maxHeartRate"] ?? 1.0) * 0.35,
                               (recentLevel["maxVelocity"] ?? 1.0) * 0.3 + (recentLevel["maxAcceleration"] ?? 1.0) * 0.2,
                               (recentLevel["maxVelocity"] ?? 1.0) * 0.25 + (recentLevel["sprintCount"] ?? 1.0) * 0.125 + (recentLevel["maxHeartRate"] ?? 1.0) * 0.125,
                               (recentLevel["maxAcceleration"] ?? 1.0) * 0.4 + (recentLevel["minHeartRate"] ?? 1.0) * 0.1,
                               (recentLevel["totalDistance"] ?? 1.0) * 0.15 + (recentLevel["rangeHeartRate"] ?? 1.0) * 0.15 + (recentLevel["totalMatchTime"] ?? 1.0) * 0.2,
                               (recentLevel["totalDistance"] ?? 1.0) * 0.3 + (recentLevel["sprintCount"] ?? 1.0) * 0.1 + (recentLevel["maxHeartRate"] ?? 1.0) * 0.1]
                
                ViewControllerContainer(ThumbnailViewController(radarAverageValue: average, radarAtypicalValue: recent))
                    .scaleEffect(CGSize(width: 0.4, height: 0.4))
                    .fixedSize()
                    .frame(width: 88, height: 88)
                
                VStack(alignment: .leading) {
                    Text(workoutData.date.description + " - " + currentLocation)
                        .foregroundStyle(Color.white.opacity(0.5))
                        .task {
                            currentLocation = await workoutData.location
                        }
                    Text("경기 시간 " + workoutData.time)
                        .foregroundStyle(Color.white)
                        .padding(.bottom)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("활동량")
                            Text(String(format: "%.1f", workoutData.distance) + "km")
                        }.foregroundStyle(
                            .linearGradient(colors: [.white, .white.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.custom("SFProText-HeavyItalic", size: 16))
                        
                        VStack(alignment: .leading) {
                            Text("최고 속도")
                            Text("\(workoutData.velocity.formatted()) km/h")
                        }.foregroundStyle(
                            .linearGradient(colors: [.white, .white.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.custom("SFProText-HeavyItalic", size: 16))
                        
                        VStack(alignment: .leading) {
                            Text("스프린트 횟수")
                            Text("\(workoutData.sprint)회")
                        }
                        .foregroundStyle(
                            .linearGradient(colors: [.white, .white.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.custom("SFProText-HeavyItalic", size: 16))
                    }
                }
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .frame(height: 114)
    }
}

//#Preview {
//    MatchListItemView(workoutData: fakeWorkoutData[0])
//        .environmentObject(HealthInteractor.shared)
//}
