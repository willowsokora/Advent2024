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
    PrintQueue()
]

let testMode = false

if testMode {
    print("***** Running in test mode *****\n")
}

for var challenge in challenges {
    guard let input = getInputText(for: challenge.challengeName, test: testMode) else {
        print("Challenge input not found for \(challenge.challengeName)")
        continue
    }
    var startTime = Date.now
    challenge.parseData(input: input)
    let parseTime = Date.now.timeIntervalSince(startTime)
    let partOne = challenge.doPartOne()
    if let partOne = partOne {
        let challengeTime = (Date.now.timeIntervalSince(startTime) + parseTime) * 1000
        print(String(format: "%@ - part two in %.3fms: %i", challenge.challengeName, challengeTime, partOne))
    } else {
        print("\(challenge.challengeName) - part one: incomplete!")
    }
    startTime = .now
    let partTwo = challenge.doPartTwo()
    if let partTwo = partTwo {
        let challengeTime = (Date.now.timeIntervalSince(startTime) + parseTime) * 1000
        print(String(format: "%@ - part two in %.3fms: %i", challenge.challengeName, challengeTime, partTwo))
    } else {
        print("\(challenge.challengeName) - part two: incomplete!")
    }
}
