//
//  GardenGroups.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/11/24.
//

import Foundation

class GardenGroups: AdventChallenge {
    
    let challengeName: String = "GardenGroups"
    
    var garden: [[String]] = []
    
    func parseData(input: String) {
        garden = input.split(separator: "\n").map { $0.split(separator: "").map(String.init) }
    }
    
    func findRegionPerimeterCount(from start: Coordinate, storage: inout Set<Coordinate>) -> Int {
        if storage.contains(start) {
            return 0
        }
        storage.insert(start)
        var exposedEdges = 4
        for dir in Direction.allCases {
            let n = start.move(in: dir)
            if n.x >= 0 && n.x < garden[0].count && n.y >= 0 && n.y < garden.count && garden[n.y][n.x] == garden[start.y][start.x] {
                exposedEdges += findRegionPerimeterCount(from: n, storage: &storage) - 1
            }
        }
        return exposedEdges
    }
    
    func findRegionEdges(from start: Coordinate, storage: inout Set<Coordinate>) -> [Direction: Set<Coordinate>] {
        if storage.contains(start) {
            return [:]
        }
        storage.insert(start)
        var edges: [Direction: Set<Coordinate>] = [:]
        for dir in Direction.allCases {
            let n = start.move(in: dir)
            if n.x >= 0 && n.x < garden[0].count && n.y >= 0 && n.y < garden.count && garden[n.y][n.x] == garden[start.y][start.x] {
                let nextEdges = findRegionEdges(from: n, storage: &storage)
                for direction in Direction.allCases {
                    edges[direction, default: []].formUnion(nextEdges[direction, default: []])
                }
            } else {
                edges[dir, default: []].insert(n)
            }
        }
        return edges
    }

    // Correct Answer: 1518548
    func doPartOne() -> Int? {
        var total = 0
        var regions: Set<Set<Coordinate>> = []
        for y in 0..<garden.count {
            for x in 0..<garden[0].count {
                if regions.contains(where: { $0.contains(Coordinate(x: x, y: y)) }) {
                    continue
                }
                var region: Set<Coordinate> = []
                let perimeter = findRegionPerimeterCount(from: Coordinate(x: x, y: y), storage: &region)
                total += region.count * perimeter
                regions.insert(region)
            }
        }
        return total
    }

    // Correct Answer: 909564
    func doPartTwo() -> Int? {
        var total = 0
        var regions: Set<Set<Coordinate>> = []
        for y in 0..<garden.count {
            for x in 0..<garden[0].count {
                if regions.contains(where: { $0.contains(Coordinate(x: x, y: y)) }) {
                    continue
                }
                var region: Set<Coordinate> = []
                let edges = findRegionEdges(from: Coordinate(x: x, y: y), storage: &region)
                var edgeCount = 0
                for dir in Direction.allCases {
                    let groups: [Int: [Int]] = edges[dir, default: []]
                        .reduce(into: [:]) { $0[dir.axis == .y ? $1.y : $1.x, default: []].append(dir.axis == .y ? $1.x : $1.y) }
                    for slice in groups.values {
                        if slice.isEmpty { continue }
                        if slice.count == 1 {
                            edgeCount += 1
                            continue
                        }
                        let sorted = slice.sorted()
                        var curr = sorted[0]
                        var count = 1
                        for a in 1..<sorted.count {
                            if sorted[a] - curr == 1 {
                                count += 1
                            } else {
                                edgeCount += 1
                                count = 1
                            }
                            curr = sorted[a]
                        }
                        edgeCount += 1
                    }
                }
                let price = region.count * edgeCount
                total += price
                regions.insert(region)
            }
        }
        return total
    }
}
