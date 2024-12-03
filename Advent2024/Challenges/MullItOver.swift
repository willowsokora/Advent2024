//
//  MullItOver.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/3/24.
//

import Foundation

struct MullItOver: AdventChallenge {
    
    let challengeName: String = "MullItOver"
    
    var mults: [(x: Int, y: Int, enabled: Bool)] = []
    
    mutating func parseData(input: String) {
        let pattern = /(mul\(((\d+),(\d+))\)|(do(?:n't)?)\(\))/
        var enabled = true
        for match in input.matches(of: pattern) {
            if match.output.5 == "do" {
                enabled = true
            } else if match.output.5 == "don't" {
                enabled = false
            } else if let xStr = match.output.3,
                      let yStr = match.output.4,
                      let x = Int(xStr),
                      let y = Int(yStr) {
                let mult = (x, y, enabled)
                mults.append(mult)
            }
        }
    }

    // Correct Answer: 175015740
    func doPartOne() -> Int? {
        mults.map { $0.x * $0.y }.reduce(into: 0) { $0 += $1 }
    }

    // Correct Answer: 112272912
    func doPartTwo() -> Int? {
        mults.filter { $0.enabled }.map { $0.x * $0.y }.reduce(into: 0) { $0 += $1 }
    }
}
