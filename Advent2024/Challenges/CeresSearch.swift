//
//  CeresSearch.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/3/24.
//

import Foundation

struct CeresSearch: AdventChallenge {
    
    let challengeName: String = "CeresSearch"
    
    var searchGrid: [[String]] = []
    
    mutating func parseData(input: String) {
        for line in input.split(separator: "\n") {
            searchGrid.append(line.split(separator: "").map { String($0) })
        }
    }
    
    let dirs = [(1, 0), (0, 1), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
    
    func getCharAt(row: Int, col: Int) -> String? {
        guard row >= 0, row < searchGrid.count, col >= 0, col < searchGrid[row].count else {
            return nil
        }
        return searchGrid[row][col]
    }

    // Correct Answer: 2397
    func doPartOne() -> Int? {
        var count = 0
        for row in 0..<searchGrid.count {
            for col in 0..<searchGrid[0].count {
                for (dirX, dirY) in dirs {
                    // for the record i know this is stupid but it looks pretty
                    let x = getCharAt(row: row + dirX * 0, col: col + dirY * 0)
                    let m = getCharAt(row: row + dirX * 1, col: col + dirY * 1)
                    let a = getCharAt(row: row + dirX * 2, col: col + dirY * 2)
                    let s = getCharAt(row: row + dirX * 3, col: col + dirY * 3)
                    if x == "X", m == "M", a == "A", s == "S" {
                        count += 1
                    }
                }
            }
        }
    	return count
    }

    // Correct Answer: 1824
    func doPartTwo() -> Int? {
    	var count = 0
        for row in 0..<searchGrid.count {
            for col in 0..<searchGrid[0].count {
                if getCharAt(row: row, col: col) == "A",
                   Set([getCharAt(row: row + 1, col: col + 1), getCharAt(row: row - 1, col: col - 1)]) == ["M", "S"],
                   Set([getCharAt(row: row - 1, col: col + 1), getCharAt(row: row + 1, col: col - 1)]) == ["M", "S"] {
                    count += 1
                }
            }
        }
        return count
    }
}
