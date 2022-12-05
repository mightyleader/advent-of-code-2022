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
        if let stringData = String(data: fileData, encoding: .utf8) {
            let splitData = Array(stringData.components(separatedBy: "\n\n"))
            //Actually doing stuff with the data
            var maxCalories = 0
            for elf in splitData {
                var elfCalories = 0
                let calorieSplit = Array(elf.components(separatedBy: "\n"))
                for calorie in calorieSplit {
                    elfCalories += Int(calorie) ?? 0
                }
                maxCalories = elfCalories > maxCalories ? elfCalories : maxCalories
            }
            print(maxCalories)
        }
    } catch {
        print("Could not read data from the file at: " + path)
    }
}


