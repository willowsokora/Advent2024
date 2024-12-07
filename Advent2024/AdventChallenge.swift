//
//  AdventChallenge.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/1/24.
//

import Foundation

protocol AdventChallenge: AnyObject {
    
    associatedtype ResultType: FixedWidthInteger
    
    var challengeName: String { get }
    
    func parseData(input: String)
    func doPartOne() -> ResultType?
    func doPartTwo() -> ResultType?
}
