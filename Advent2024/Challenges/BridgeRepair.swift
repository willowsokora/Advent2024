//
//  BridgeRepair.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/7/24.
//

import Foundation

class BridgeRepair: AdventChallenge {
    
    let challengeName: String = "BridgeRepair"
    
    var equations: [(equation: [Int], solution: Int)] = []
    
    func parseData(input: String) {
        for line in input.split(separator: "\n") {
            let parts = line.split(separator: ":")
            guard let solution = Int(parts[0]) else { continue }
            let equation = parts[1].split(separator: " ").compactMap { Int($0) }
            equations.append((equation, solution))
        }
    }
    
    func isSolvable(solution: Int, equation: [Int], currentValue: Int, with operators: [Operator]) -> Bool {
        guard let nextOperand = equation.first, currentValue <= solution else {
            return solution == currentValue
        }
        
        let newEquation = Array(equation[1...])
        
        for op in operators {
            if isSolvable(
                solution: solution,
                equation: newEquation,
                currentValue: op.perform(currentValue, nextOperand),
                with: operators
            ) {
                return true
            }
        }
        return false
    }

    // Correct Answer: 1985268524462
    func doPartOne() -> UInt64? {
        return equations.filter { eq in
            return isSolvable(
                solution: eq.solution,
                equation: Array(eq.equation[1...]),
                currentValue: eq.equation[0],
                with: [.add, .multiply]
            )
        }.map { UInt64($0.solution) }.reduce(UInt64(0), +)
    }

    // Correct Answer: 150077710195188
    func doPartTwo() -> UInt64? {
        return equations.filter { eq in
            return isSolvable(
                solution: eq.solution,
                equation: Array(eq.equation[1...]),
                currentValue: eq.equation[0],
                with: [.add, .multiply, .concat]
            )
        }.map { UInt64($0.solution) }.reduce(UInt64(0), +)
    }
    
    enum Operator {
        case add
        case multiply
        case concat
        
        func perform(_ a: Int, _ b: Int) -> Int {
            switch self {
            case .add: return a + b
            case .multiply: return a * b
            case .concat: return Int("\(a)\(b)")!
            }
        }
    }
}
