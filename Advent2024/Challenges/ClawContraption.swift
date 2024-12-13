//
//  ClawContraption.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/12/24.
//

import Foundation

class ClawContraption: AdventChallenge {
    
    let challengeName: String = "ClawContraption"
    
    var contraptions: [Contraption] = []
    
    func parseData(input: String) {
        let pattern = /Button A: X\+(\d+), Y\+(\d+)\nButton B: X\+(\d+), Y\+(\d+)\nPrize: X=(\d+), Y=(\d+)/
        contraptions = input.matches(of: pattern).compactMap { match in
            guard let aX = Int(match.output.1), let aY = Int(match.output.2),
               let bX = Int(match.output.3), let bY = Int(match.output.4),
               let prizeX = Int(match.output.5), let prizeY = Int(match.output.6) else {
                return nil
            }
            return Contraption(aX: aX, aY: aY, bX: bX, bY: bY, prizeX: prizeX, prizeY: prizeY)
        }
    }
    
    func getTokensToPrize(for contraption: Contraption) -> Int {
        let a = (contraption.prizeX * contraption.bY - contraption.prizeY * contraption.bX) / (contraption.aX * contraption.bY - contraption.aY * contraption.bX)
        if a * (contraption.aX * contraption.bY - contraption.aY * contraption.bX) != contraption.prizeX * contraption.bY - contraption.prizeY * contraption.bX {
            return 0
        }
        let b = (contraption.prizeY - contraption.aY * a) / contraption.bY
        if b * contraption.bY != contraption.prizeY - contraption.aY * a {
            return 0
        }
        return 3 * a + b
    }

    // Correct Answer: 38714
    func doPartOne() -> Int? {
        var total = 0
        for contraption in contraptions {
            total += getTokensToPrize(for: contraption)
        }
        return total
    }

    // Correct Answer: 74015623345775
    func doPartTwo() -> Int? {
        var total = 0
        for contraption in contraptions.map({ Contraption(aX: $0.aX, aY: $0.aY, bX: $0.bX, bY: $0.bY, prizeX: $0.prizeX + 10000000000000, prizeY: $0.prizeY + 10000000000000) }) {
            total += getTokensToPrize(for: contraption)
        }
    	return total
    }
}

struct Contraption {
    let aX, aY, bX, bY, prizeX, prizeY: Int
}
