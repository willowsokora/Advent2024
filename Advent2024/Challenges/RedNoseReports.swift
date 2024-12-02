//
//  RedNoseReports.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/2/24.
//

import Foundation

struct RedNoseReports: AdventChallenge {
    let challengeName: String = "RedNoseReports"
    
    var reports: [[Int]] = []
    
    mutating func parseData(input: String) {
        let reportLines = input.split(separator: "\n")
        for line in reportLines {
            let report = line.split(separator: " ").map { Int($0)! }
            reports.append(report)
        }
    }
    
    func isSafe(report: [Int]) -> Bool {
        if report[1] < report[0] {
            for i in 1..<report.count {
                let last = report[i-1]
                let valid = [last - 1, last - 2, last - 3]
                if !valid.contains(report[i]) {
                    return false
                }
            }
        } else if report[1] > report[0] {
            for i in 1..<report.count {
                let last = report[i-1]
                let valid = [last + 1, last + 2, last + 3]
                if !valid.contains(report[i]) {
                    return false
                }
            }
        } else {
            return false
        }
        return true
    }
    
    func checkWithTolerance(report: [Int]) -> Bool {
        let alertnates = (0..<report.count).map { i in
            var alt = report
            alt.remove(at: i)
            return alt
        }
        for alternate in alertnates {
            if isSafe(report: alternate) {
                return true
            }
        }
        return false
    }
    
    // Correct Answer: 631
    func doPartOne() -> Int? {
        var count = 0
        for report in reports {
            let safe = isSafe(report: report)
            if safe {
                count += 1
            }
        }
        return count
    }
    
    // Correct Answer: 665
    func doPartTwo() -> Int? {
        var count = 0
        for report in reports {
            if isSafe(report: report) {
                count += 1
            } else if checkWithTolerance(report: report) {
                count += 1
            }
        }
        return count
    }
}
