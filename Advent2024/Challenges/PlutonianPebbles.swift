//
//  PlutonianPebbles.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/10/24.
//

import Foundation

class PlutonianPebbles: AdventChallenge {
    
    let challengeName: String = "PlutonianPebbles"
    
    var stones: [Int] = []
    var cache: [StoneState: Int] = [:]
    
    func parseData(input: String) {
        stones = input.split(separator: " ").map(String.init).compactMap(Int.init)
    }
    
    func processBlink(for number: Int) -> [Int] {
        if number == 0 {
            return [1]
        }
        let numString = "\(number)"
        if numString.count.isMultiple(of: 2) {
            let halfIndex = numString.index(numString.startIndex, offsetBy: numString.count / 2)
            guard let a = Int(numString[numString.startIndex..<halfIndex]),
                  let b = Int(numString[halfIndex..<numString.endIndex]) else {
                return []
            }
            return [a, b]
        }
        return [number * 2024]
    }
    
    func getTotalStones(for value: Int, blinks: Int, cache: inout [StoneState: Int]) -> Int {
        if blinks == 0 {
            return 1
        }
        let stoneState = StoneState(value: value, blinks: blinks)
        if let cachedValue = cache[stoneState] {
            return cachedValue
        }
        let sub = processBlink(for: value)
        var total = 0
        for val in sub {
            total += getTotalStones(for: val, blinks: blinks - 1, cache: &cache)
        }
        cache[stoneState] = total
        return total
    }
    
    func blink(_ blinks: Int) -> Int {
        var total = 0
        for stone in stones {
            total += getTotalStones(for: stone, blinks: blinks, cache: &cache)
        }
        return total
    }

    // Correct Answer: 190865
    func doPartOne() -> Int? {
        return blink(25)
    }

    // Correct Answer: 225404711855335
    func doPartTwo() -> Int? {
        return blink(75)
    }
}

struct StoneState: Hashable {
    let value: Int
    let blinks: Int
}
