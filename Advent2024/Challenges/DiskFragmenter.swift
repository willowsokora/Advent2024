//
//  DiskFragmenter.swift
//  Advent2024
//
//  Created by Willow Sokora on 12/8/24.
//

import Foundation

class DiskFragmenter: AdventChallenge {
    
    let challengeName: String = "DiskFragmenter"
    
    var diskMap: [Int] = []
    
    func parseData(input: String) {
        var freeSpace = false
        var i = 0
        for x in input.split(separator: "").map(String.init).compactMap(Int.init) {
            if freeSpace {
                diskMap.append(contentsOf: Array(repeating: -1, count: x))
            } else {
                diskMap.append(contentsOf: Array(repeating: i, count: x))
                i += 1
            }
            freeSpace = !freeSpace
        }
    }

    // Correct Answer: 6435922584968
    func doPartOne() -> Int? {
        var frag = diskMap
        var f = frag.count
        for i in 0..<frag.count {
            if frag[i] == -1 {
                if i > f { break }
                for j in (i..<f).reversed() {
                    if frag[j] != -1 {
                        frag[i] = frag[j]
                        frag[j] = -1
                        f = j
                        break
                    }
                }
            }
        }
        return frag.enumerated().map { $0 * $1 }.filter { $0 > 0 }.reduce(0, +)
    }

    // Correct Answer: 6469636832766
    func doPartTwo() -> Int? {
        var defrag = diskMap
        guard let m = defrag.max() else { return nil }
        var emptyRange: ClosedRange<Int>?
        var (files, empties): (files: [Int: ClosedRange<Int>], empties: [ClosedRange<Int>]) = defrag.enumerated().reduce(into: ([:], [])) { d,e in
            let x = e.element
            let i = e.offset
            if x != -1 {
                if let empty = emptyRange {
                    d.empties.append(empty)
                    emptyRange = nil
                }
                let min = min(d.files[x]?.lowerBound ?? i, i)
                let max = max(d.files[x]?.upperBound ?? i, i)
                d.files[x] = min...max
            } else if let empty = emptyRange {
                let min = min(empty.lowerBound, i)
                let max = max(empty.upperBound, i)
                emptyRange = min...max
            } else {
                emptyRange = i...i
            }
        }
        for x in (0...m).reversed() {
            guard let r = files[x], let eI = empties.firstIndex(where: { $0.count >= r.count && $0.upperBound < r.lowerBound }) else { continue }
            let e = empties[eI]
            defrag.replaceSubrange(r, with: [Int](repeating: -1, count: r.count))
            defrag.replaceSubrange(e.lowerBound..<e.lowerBound + r.count, with: [Int](repeating: x, count: r.count))
            empties.remove(at: eI)
            if e.count > r.count {
                empties.insert(e.lowerBound + r.count...e.upperBound, at: eI)
            }
            empties.insert(r, at: empties.firstIndex(where: { $0.lowerBound > r.upperBound }) ?? empties.endIndex)
        }
        return defrag.enumerated().map { $0 * $1 }.filter { $0 > 0 }.reduce(0, +)
    }
}
