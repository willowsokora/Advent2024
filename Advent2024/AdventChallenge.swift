//
//  AdventChallenge.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/1/24.
//

import Foundation

protocol AdventChallenge {
    
    var challengeName: String { get }
    
    mutating func parseData(input: String)
    func doPartOne() -> Int?
    func doPartTwo() -> Int?
}
