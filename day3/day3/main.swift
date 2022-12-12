//
//  main.swift
//  day3
//
//  Created by Robert Stearn on 06/12/2022.
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
        if let stringData = String(data: fileData, encoding: .utf8) {
            let rucksacks = Array(stringData.components(separatedBy: "\n"))
//            let total = rucksacks.map{ priorityFromRucksack(rucksack: $0) }.reduce(0,+)
            var group = [String]()
            var container = [[String]]()
            var index = 0
            for rucksack in rucksacks {
                group.append(rucksack)
                if (index == 2)
                {
                    container.append(group)
                    group.removeAll()
                    index = 0
                } else {
                    index += 1
                }
            }
            print(priorityFromRucksacks(rucksacks: container))
            
        } else {
            print("ERROR: Could not parse data from file.")
        }
        
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func priorityFromRucksacks(rucksacks: [[String]]) -> Int {
    let prioritizedValues = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var count = 0
    for trio in rucksacks {
        let firstCompare = Set(trio[0]).intersection(trio[1])
        let secondCompare = firstCompare.intersection(trio[2])
        let priorityValue = (prioritizedValues.firstIndex(of: secondCompare.first!)?.utf16Offset(in: prioritizedValues) ?? 0) + 1
        count += priorityValue
        print("\(secondCompare) gives: \(priorityValue )")
    }
    return count
}
