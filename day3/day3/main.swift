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
            let total = rucksacks.map{ priorityFromRucksack(rucksack: $0) }.reduce(0,+)
            print(total)
        } else {
            print("ERROR: Could not parse data from file.")
        }
        
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func priorityFromRucksack(rucksack: String) -> Int {
    let prioritizedValues = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var count = 0
    if (rucksack.count >= 2) {
        let length = Int(rucksack.count / 2)
        //split into 2 sets of characters
        let index = rucksack.index(rucksack.startIndex, offsetBy: length)
        let leftSide = rucksack[...index]
        let rightSide = rucksack[index...]
        //calculate intersection
        for char in leftSide {
            if let index = rightSide.firstIndex(of: char) {
                count = prioritizedValues.firstIndex(of: char)!.utf16Offset(in: prioritizedValues) + 1
                print("\(char) at: \(count)")
                break
            }
        }
        
    }
    return count
}
