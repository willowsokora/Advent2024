//
//  GuardGallivant.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/5/24.
//

import Foundation

class GuardGallivant: AdventChallenge {
    
    let challengeName: String = "GuardGallivant"
    
    var map: [[String]] = []
    var startCoordinate: Coordinate = Coordinate(x: 0, y: 0)
    var visited: Set<Coordinate> = []
    
    func parseData(input: String) {
        map = input.split(separator: "\n").map { $0.split(separator: "").map { String($0) } }
        guard let y = map.firstIndex(where: { $0.contains("^") }),
              let x = map[y].firstIndex(of: "^") else {
            return
        }
        startCoordinate = Coordinate(x: x, y: y)
        _ = traverseGuardPath()
    }
    
    func traverseGuardPath(blocking: Coordinate? = nil) -> Bool {
        var turns: Set<Turn> = []
        var pos = startCoordinate
        var direction: Direction = .up
        while true {
            visited.insert(pos)
            let newPos = pos.move(in: direction)
            if newPos.y >= 0 && newPos.x >= 0 && newPos.y < map.count && newPos.x < map[0].count {
                if map[newPos.y][newPos.x] == "#" || newPos == blocking {
                    let turn = Turn(pos: pos, direction: direction)
                    if turns.contains(turn) {
                        return true
                    }
                    direction = direction.next
                    turns.insert(turn)
                } else {
                    pos = newPos
                }
            } else {
                return false
            }
        }
    }
    
    // Correct Answer: 5095
    func doPartOne() -> Int? {
        return visited.count
    }
    
    // Correct Answer: 1933
    func doPartTwo() -> Int? {
        return visited.filter { traverseGuardPath(blocking: $0) }.count
    }
}

struct Turn: Hashable {
    let pos: Coordinate
    let direction: Direction
}

struct Coordinate: Hashable {
    let x, y: Int
    
    func move(in direction: Direction, backward: Bool = false) -> Coordinate {
        if backward {
            return Coordinate(x: x - direction.x, y: y - direction.y)
        } else {
            return Coordinate(x: x + direction.x, y: y + direction.y)
        }
    }
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
    
    var x: Int {
        switch self {
        case .up: return 0
        case .right: return 1
        case .down: return 0
        case .left: return -1
        }
    }
    
    var y: Int {
        switch self {
        case .up: return -1
        case .right: return 0
        case .down: return 1
        case .left: return 0
        }
    }
    
    var next: Direction {
        switch self {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        }
    }
    
    var axis: Axis {
        return y == 0 ? .x : .y
    }
}

enum Axis {
    case x, y
}
