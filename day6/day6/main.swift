//
//  main.swift
//  day6
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
        if let stringFromData = String(data: fileData, encoding: .utf8) {
            let index = indexOf(messageBody: stringFromData)
            print(index + 4)
        }
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func indexOf(messageBody string: String) -> Int {
    var mutableString = string
    for index in string.indices {
        let comparisonPrefix = mutableString.prefix(4)
        if Set(comparisonPrefix).count == 4 {
            return index.utf16Offset(in: string)
        }
        mutableString = String(mutableString.dropFirst())
        //print("\(index.utf16Offset(in: string)): \(comparisonPrefix)")
    }
    return 0
}
