//
//  HoofIt.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/9/24.
//

import Foundation

class HoofIt: AdventChallenge {
    
    let challengeName: String = "HoofIt"
    
    var map: [[Int]] = []
    
    func parseData(input: String) {
        map = input.split(separator: "\n").map { $0.split(separator: "").map(String.init).compactMap(Int.init) }
    }
    
    func findTrails(from coord: Coordinate) -> [Coordinate] {
        var trails: [Coordinate] = []
        let currentHeight = map[coord.y][coord.x]
        for direction in Direction.allCases {
            let next = coord.move(in: direction)
            if next.x >= 0 && next.x < map[0].count && next.y >= 0 && next.y < map.count {
                let nextHeight = map[next.y][next.x]
                if nextHeight - currentHeight != 1 {
                    continue
                } else if nextHeight == 9 {
                    trails.append(next)
                } else {
                    trails.append(contentsOf: findTrails(from: next))
                }
            }
        }
        return trails
    }

    func doPartOne() -> Int? {
        var count = 0
        for y in 0..<map.count {
            for x in 0..<map[0].count {
                if map[y][x] == 0 {
                    count += Set(findTrails(from: Coordinate(x: x, y: y))).count
                }
            }
        }
        return count
    }

    func doPartTwo() -> Int? {
        var count = 0
        for y in 0..<map.count {
            for x in 0..<map[0].count {
                if map[y][x] == 0 {
                    count += findTrails(from: Coordinate(x: x, y: y)).count
                }
            }
        }
        return count
    }
}
