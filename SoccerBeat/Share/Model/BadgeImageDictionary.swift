//
//  BadgeImages.swift
//  SoccerBeat
//
//  Created by Hyungmin Kim on 11/20/23.
//

import Foundation

let BadgeImageDictionary: [[Int: String]] = [[
    -1: "",
     0: "DistanceFirstUnlocked",
     1: "DistanceSecondUnlocked",
     2: "DistanceThirdUnlocked",
     3: "DistanceFourthUnlocked"
], [
    -1: "",
     0: "SprintFirstUnlocked",
     1: "SprintSecondUnlocked",
     2: "SprintThirdUnlocked",
     3: "SprintFourthUnlocked"
], [
    -1: "",
     0: "VelocityFirstUnlocked",
     1: "VelocitySecondUnlocked",
     2: "VelocityThirdUnlocked",
     3: "VelocityFourthUnlocked"
]
]

let badgeUnlockedImages: [[String]] = [
    ["DistanceFirstUnlocked", "DistanceSecondUnlocked", "DistanceThirdUnlocked", "DistanceFourthUnlocked"],
    ["SprintFirstUnlocked", "SprintSecondUnlocked", "SprintThirdUnlocked", "SprintFourthUnlocked"],
    ["VelocityFirstUnlocked", "VelocitySecondUnlocked", "VelocityThirdUnlocked", "VelocityFourthUnlocked"]
]

let badgeLockedImages: [[String]] = [
    ["DistanceFirstLocked", "DistanceSecondLocked", "DistanceThirdLocked", "DistanceFourthLocked"],
    ["SprintFirstLocked", "SprintSecondLocked", "SprintThirdLocked", "SprintFourthLocked"],
    ["VelocityFirstLocked", "VelocitySecondLocked", "VelocityThirdLocked", "VelocityFourthLocked"]
]
