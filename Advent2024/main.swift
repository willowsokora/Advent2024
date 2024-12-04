//
//  main.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/1/24.
//

import Foundation

func getInputText(for challengeName: String, test: Bool = false) -> String {
    return try! String(contentsOfFile: "/Users/willow/dev/Advent2024/Advent2024/Inputs/\(challengeName)\(test ? "-test" : "").txt", encoding: .utf8)
}

let challenges: [any AdventChallenge] = [
    HistorianHysteria(),
    RedNoseReports(),
    MullItOver(),
    CeresSearch()
]

let testMode = false

if testMode {
    print("***** Running in test mode *****\n")
}

for var challenge in challenges {
    let input = getInputText(for: challenge.challengeName, test: testMode)
    challenge.parseData(input: input)
    let partOne = challenge.doPartOne()
    if let partOne = partOne {
        print("\(challenge.challengeName) - part one: \(partOne)")
    } else {
        print("\(challenge.challengeName) - part one: incomplete!")
    }
    let partTwo = challenge.doPartTwo()
    if let partTwo = partTwo {
        print("\(challenge.challengeName) - part two: \(partTwo)")
    } else {
        print("\(challenge.challengeName) - part two: incomplete!")
    }
}
