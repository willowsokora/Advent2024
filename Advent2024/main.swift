//
//  main.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/1/24.
//

import Foundation

func getInputText(for challengeName: String, test: Bool = false) -> String? {
    return try? String(contentsOfFile: "/Users/willow/dev/Advent2024/Advent2024/Inputs/\(challengeName)\(test ? "-test" : "").txt", encoding: .utf8)
}

let challenges: [any AdventChallenge] = [
    HistorianHysteria(),
    RedNoseReports(),
    MullItOver(),
    CeresSearch(),
    PrintQueue(),
    GuardGallivant()
]

let testMode = false

if testMode {
    print("***** Running in test mode *****\n")
}

for challenge in challenges {
    guard let input = getInputText(for: challenge.challengeName, test: testMode) else {
        print("Challenge input not found for \(challenge.challengeName)")
        continue
    }
    var startTime = Date.now
    challenge.parseData(input: input)
    let parseTime = Date.now.timeIntervalSince(startTime)
    let partOne = challenge.doPartOne()
    if let partOne = partOne {
        var timeSuffix = "s"
        var challengeTime = (Date.now.timeIntervalSince(startTime) + parseTime)
        if challengeTime < 1 {
            timeSuffix = "ms"
            challengeTime *= 1000
        }
        print(String(format: "%@ - part two in %.3f%@: %i", challenge.challengeName, challengeTime, timeSuffix, partOne))
    } else {
        print("\(challenge.challengeName) - part one: incomplete!")
    }
    startTime = .now
    let partTwo = challenge.doPartTwo()
    if let partTwo = partTwo {
        var timeSuffix = "s"
        var challengeTime = (Date.now.timeIntervalSince(startTime) + parseTime)
        if challengeTime < 1 {
            timeSuffix = "ms"
            challengeTime *= 1000
        }
        print(String(format: "%@ - part two in %.2f%@: %i", challenge.challengeName, challengeTime, timeSuffix, partTwo))
    } else {
        print("\(challenge.challengeName) - part two: incomplete!")
    }
}
