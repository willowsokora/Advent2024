//
//  RestroomRedoubt.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/13/24.
//

import Foundation

class RestroomRedoubt: AdventChallenge {
    
    let challengeName: String = "RestroomRedoubt"
    
    var robots: [(pos: Coordinate, v: Coordinate)] = []
    let height = testMode ? 7 : 103
    let width = testMode ? 11 : 101
    
    func parseData(input: String) {
        let pattern = /p=(\d+),(\d+) v=(-?\d+),(-?\d+)/
        robots = input.matches(of: pattern).map { (Coordinate(x: Int($0.output.1)!, y: Int($0.output.2)!), Coordinate(x: Int($0.output.3)!, y: Int($0.output.4)!))}
    }
    
    func getPositionOfRobot(startingAt start: Coordinate, with velocity: Coordinate, after seconds: Int) -> Coordinate {
        if seconds == 0 {
            return start
        }
        let next = getNextRobotPosition(from: start, with: velocity)
        return getPositionOfRobot(startingAt: next, with: velocity, after: seconds - 1)
    }
    
    func getNextRobotPosition(from start: Coordinate, with velocity: Coordinate) -> Coordinate {
        var x = start.x + velocity.x
        var y = start.y + velocity.y
        if y < 0 {
            y = height + y
        } else if y >= height {
            y = y - height
        }
        if x < 0 {
            x = width + x
        } else if x >= width {
            x = x - width
        }
        return Coordinate(x: x, y: y)
    }

    // Correct Answer: 221655456
    func doPartOne() -> Int? {
        var finalPositions: [Coordinate] = []
        for robot in robots {
            finalPositions.append(getPositionOfRobot(startingAt: robot.pos, with: robot.v, after: 100))
        }
        return finalPositions.reduce(into: [0, 0, 0, 0]) { result, next in
            let centerX = width / 2
            let centerY = height / 2
            if next.x < centerX && next.y < centerY {
                result[0] += 1
            } else if next.x < centerX && next.y > centerY {
                result[1] += 1
            } else if next.x > centerX && next.y > centerY {
                result[2] += 1
            } else if next.x > centerX && next.y < centerY {
                result[3] += 1
            }
        }.reduce(into: 1) { $0 *= $1 }
    }

    // Correct Answer: 7858
    func doPartTwo() -> Int? {
        for i in 1..<Int.max {
            var positions: Set<Coordinate> = []
            for i in 0..<robots.count {
                let robot = robots[i]
                let next = getNextRobotPosition(from: robot.pos, with: robot.v)
                robots[i] = (next, robot.v)
                positions.insert(next)
            }
            if positions.count == robots.count {
                return i
            }
        }
        return -1
    }
}
