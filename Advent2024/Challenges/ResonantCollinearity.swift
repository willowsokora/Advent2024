//
//  ResonantCollinearity.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/8/24.
//

import Foundation

class ResonantCollinearity: AdventChallenge {
    
    let challengeName: String = "ResonantCollinearity"
    
    var height: Int = 0
    var width: Int = 0
    var nodes: [String: [Coordinate]] = [:]
    
    func parseData(input: String) {
        let lines = input.split(separator: "\n")
        height = lines.count
        width = lines[0].count
        for (row, line) in lines.enumerated() {
            for (col, char) in line.split(separator: "").map(String.init).enumerated() {
                if char != "." {
                    nodes[char, default: []].append(Coordinate(x: col, y: row))
                }
            }
        }
    }
    
    func findAntiNodes(for nodes: [Coordinate]) -> Set<Coordinate> {
        var antiNodes: Set<Coordinate> = []
        for a in nodes {
            for b in nodes {
                if a == b { continue }
                let dx = abs(a.x - b.x)
                let dy = abs(a.y - b.y)
                let aX = a.x < b.x ? a.x - dx : a.x + dx
                let aY = a.y < b.y ? a.y - dy : a.y + dy
                let bX = b.x < a.x ? b.x - dx : b.x + dx
                let bY = b.y < a.y ? b.y - dy : b.y + dy
                if aX >= 0 && aX < width && aY >= 0 && aY < height {
                    antiNodes.insert(Coordinate(x: aX, y: aY))
                }
                if bX >= 0 && bX < width && bY >= 0 && bY < height {
                    antiNodes.insert(Coordinate(x: bX, y: bY))
                }
            }
        }
        return antiNodes
    }
    
    func findAntiNodesWithHarmonics(for nodes: [Coordinate]) -> Set<Coordinate> {
        var antiNodes: Set<Coordinate> = []
        for a in nodes {
            for b in nodes {
                if a == b { continue }
                antiNodes.formUnion([a, b])
                let dx = abs(a.x - b.x)
                let dy = abs(a.y - b.y)
                var aX = a.x < b.x ? a.x - dx : a.x + dx
                var aY = a.y < b.y ? a.y - dy : a.y + dy
                var bX = b.x < a.x ? b.x - dx : b.x + dx
                var bY = b.y < a.y ? b.y - dy : b.y + dy
                var aO = 1
                var bO = 1
                while aX >= 0 && aX < width && aY >= 0 && aY < height {
                    antiNodes.insert(Coordinate(x: aX, y: aY))
                    aO += 1
                    aX = a.x < b.x ? a.x - dx * aO : a.x + dx * aO
                    aY = a.y < b.y ? a.y - dy * aO : a.y + dy * aO
                }
                if bX >= 0 && bX < width && bY >= 0 && bY < height {
                    antiNodes.insert(Coordinate(x: bX, y: bY))
                    bO += 1
                    bX = b.x < a.x ? b.x - dx * bO : b.x + dx * bO
                    bY = b.y < a.y ? b.y - dy * bO : b.y + dy * bO
                }
            }
        }
        return antiNodes
    }

    func doPartOne() -> Int? {
        return nodes
            .mapValues(findAntiNodes(for:))
            .reduce(into: Set<Coordinate>()) { $0.formUnion($1.value) }
            .count
    }

    func doPartTwo() -> Int? {
        return nodes
            .mapValues(findAntiNodesWithHarmonics(for:))
            .reduce(into: Set<Coordinate>()) { $0.formUnion($1.value) }
            .count
    }
}
