//
//  main.swift
//  aoc22
//
//  Created by Robert Stearn on 05/12/2022.
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
        print("Total of top 3 elves: \(topThreeCaloriesTotal(fileData: fileData))")
        print("Highest calories: \( mostCalories(fileData: fileData))")
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}


func mostCalories(fileData: Data) -> Int {
    var maxCalories = 0
    if let stringData = String(data: fileData, encoding: .utf8) {
        let splitData = Array(stringData.components(separatedBy: "\n\n"))
        //Actually doing stuff with the data
        for elf in splitData {
            var elfCalories = 0
            let calorieSplit = Array(elf.components(separatedBy: "\n"))
            for calorie in calorieSplit {
                elfCalories += Int(calorie) ?? 0
            }
            maxCalories = elfCalories > maxCalories ? elfCalories : maxCalories
        }
    } else {
        print("ERROR: Could not parse data from file.")
    }
    return maxCalories
}

func topThreeCaloriesTotal(fileData: Data) -> Int {
    if let stringData = String(data: fileData, encoding: .utf8) {
        let splitData = Array(stringData.components(separatedBy: "\n\n"))
        //Actually doing stuff with the data
        let parsedTotals = splitData
            .map { Array($0.components(separatedBy: "\n")) } //Map String to String Array
            .map { $0.map{Int($0) ?? 0 } //Map String Array to Int Array
            .reduce(0,+) } //Total each Int Array
            .sorted { a, b in a > b } //Order by value decreasing
        return parsedTotals[0...2].reduce(0,+)
    }
    return 0
}
