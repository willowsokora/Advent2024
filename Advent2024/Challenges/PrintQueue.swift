//
//  PrintQueue.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/5/24.
//

import Foundation

class PrintQueue: AdventChallenge {
    
    let challengeName: String = "PrintQueue"
    
    var queue: [Int: [Int]] = [:]
    var correctUpdates: [[Int]] = []
    var incorrectUpdates: [[Int]] = []
    
    func parseData(input: String) {
        let pattern = /(?:(\d+)\|(\d+))|((?:\d+,?)+)/
        for match in input.matches(of: pattern) {
            if let aStr = match.output.1, let bStr = match.output.2,
               let a = Int(aStr), let b = Int(bStr) {
                queue[b, default: []].append(a)
            } else if let updateStr = match.output.3 {
                let update = updateStr.split(separator: ",").map { Int($0)! }
                let sorted = update.sorted { queue[$1, default: []].contains($0) }
                if update == sorted {
                    correctUpdates.append(update)
                } else {
                    incorrectUpdates.append(sorted)
                }
            }
        }
    }

    // Correct Answer: 4689
    func doPartOne() -> Int? {
        return correctUpdates.reduce(0) { $0 + $1[$1.count / 2] }
    }

    // Correct Answer: 6336
    func doPartTwo() -> Int? {
        return incorrectUpdates.reduce(0) { $0 + $1[$1.count / 2] }
    }
}
