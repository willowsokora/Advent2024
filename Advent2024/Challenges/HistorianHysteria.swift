//
//  HistorianHysteria.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/1/24.
//

import Foundation

struct HistorianHysteria: AdventChallenge {
    let challengeName: String = "HistorianHysteria"
    
    var colOne: [Int] = []
    var colTwo: [Int] = []
    
    mutating func parseData(input: String) {
        for line in input.split(separator: "\n") {
            let numbers = line.split(separator: "   ")
            colOne.append(Int(numbers[0])!)
            colTwo.append(Int(numbers[1])!)
        }
        colOne.sort()
        colTwo.sort()
    }
    
    // Correct Answer: 2000468
    func doPartOne() -> Int? {
        var total = 0
        for i in 0..<min(colOne.count, colTwo.count) {
            var max = max(colOne[i], colTwo[i])
            var min = min(colOne[i], colTwo[i])
            total += max - min
        }
        return total
    }
    
    // Corrrect Answer: 18567089
    func doPartTwo() -> Int? {
        var total = 0
        for i in colOne {
            var count = colTwo.count { $0 == i }
            total += i * count
        }
        return total
    }
}
