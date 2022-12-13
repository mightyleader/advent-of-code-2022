//
//  main.swift
//  day5
//
//  Created by Robert Stearn on 13/12/2022.
//

//Starting positions
//[M]                     [N] [Z]
//[F]             [R] [Z] [C] [C]
//[C]     [V]     [L] [N] [G] [V]
//[W]     [L]     [T] [H] [V] [F] [H]
//[T]     [T] [W] [F] [B] [P] [J] [L]
//[D] [L] [H] [J] [C] [G] [S] [R] [M]
//[L] [B] [C] [P] [S] [D] [M] [Q] [P]
//[B] [N] [J] [S] [Z] [W] [F] [W] [R]
// 1   2   3   4   5   6   7   8   9

import Foundation

//Get input data
let args = CommandLine.arguments
var stacks = [["B","L","D","T","W","C","F","M"],
              ["N","B","L"],
              ["J","C","H","T","L","V"],
              ["S","P","J","W"],
              ["Z","S","C","F","T","L","R"],
              ["W","D","G","B","H","N","Z"],
              ["F","M","S","P","V","G","C","N"],
              ["W","Q","R","J","F","V","C","Z"],
              ["R","P","M","L","H"]]

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
            let cleanData = cleanup(stringData: stringData)
            for instructions in cleanData {
                process(instructions: instructions)
            }
        }
        let result = stacks.map{ $0.last }
        print(result)
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func cleanup(stringData data: String) -> [[Int]] {
    var lineData = Array(data.components(separatedBy: "\n")) //into an array
    lineData.removeSubrange(0...9) //remove the starting point data
    return lineData.map{
        let strippedLine = $0.dropFirst(5)
            .replacingOccurrences(of: " from ", with: ",")
            .replacingOccurrences(of: " to ", with: ",")
        return Array(strippedLine.components(separatedBy: ",")).map{ Int($0) ?? 0 }
    }
}

func process(instructions instr: [Int]) -> Void {
    if instr[0] == 0 || instr[1] == 0 || instr[2] == 0 { return }
    var source = stacks[instr[1] - 1]
    var destination = stacks[instr[2] - 1]
    let range = instr[0]
    destination.append(contentsOf: source[(source.count - range)...])
    source.removeLast(range)
    stacks[instr[1] - 1] = source
    stacks[instr[2] - 1] = destination
}
