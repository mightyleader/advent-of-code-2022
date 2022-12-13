//
//  main.swift
//  day4
//
//  Created by Robert Stearn on 13/12/2022.
//

import Foundation

//Get input data
let args = CommandLine.arguments

//Fail on no file
if args.count < 2 {
    print("No input file specified.")
} else {
    let path = args[1]
    let fileURL = URL(filePath: path)
    
    do {
        //Getting the contents of the file if the file is parsable
        let fileData = try Data(contentsOf: fileURL)
        let total = parseFileData(data: fileData)
        print("Total of containing matches: \(total)")

    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func parseFileData(data: Data) -> Int {
    var count = 0
    if let stringData = String(data: data, encoding: .utf8) {
        let splitData = Array(stringData.components(separatedBy: "\n"))
        let lineSplit = splitData.map {
            return Array($0.components(separatedBy: ",")).map{
                Array($0.components(separatedBy: "-")).map{ Int($0)}
            }
        }
        count = lineSplit.map {
            if $0.count < 2 { return 0 }
            let range1 = Range($0[0][0]!...$0[0][1]!)
            let range2 = Range($0[1][0]!...$0[1][1]!)
            if (range1.overlaps(range2)) {
                print("OVERLAP: \(range1) - \(range2)")
                return 1
            }
            return 0
        }.reduce(0, +)
        print(count)
    }
    return count
}
    
