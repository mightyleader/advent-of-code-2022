//
//  main.swift
//  day2
//
//  Created by Robert Stearn on 06/12/2022.


import Foundation

//  Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose the same shape, the round instead ends in a draw.
//  Rock = A or X
//  Paper = B or Y
//  Scissors = C or Z

enum Play: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

enum Result: Int {
    case win = 6
    case lose = 0
    case draw = 3
}

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
            let rounds = Array(stringData.components(separatedBy: "\n"))
            let total = rounds.map { playRound(round: $0) }.reduce(0, +)
            print("Total score is: \(total)")
        } else {
            print("ERROR: Could not parse data from file.")
        }
        
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

private func playRound(round: String) -> Int {
    if round.count != 3 { return 0 }
    let theirPlay = playFromString(letter: round.first!) //Hacky force unwrap :(
    let theResult = resultFromString(letter: round.last!)
    return scoreFrom(theirPlay: theirPlay, and: theResult)
}

private func playFromString(letter: Character) -> Play {
    switch letter {
    case "A", "a":
        return .rock
    case "B", "b":
        return .paper
    case "C", "c":
        return .scissors
    default:
        return .rock
    }
}

private func resultFromString(letter: Character) -> Result {
    switch letter {
    case "X", "x":
        return .lose
    case "Y", "y":
        return .draw
    case "Z", "z":
        return .win
    default:
        return .lose
    }
}

private func scoreFrom(theirPlay: Play, and theResult: Result) -> Int {
    let myPlayScore = fight(result: theResult, them: theirPlay).rawValue
    let resultScore = theResult.rawValue
    return (myPlayScore + resultScore)
}

private func fight(result: Result, them: Play) -> Play {
    if (result == .draw) { return them }
    let turn = (result, them)
    switch turn {
    case(.lose, .rock):
        return .scissors
    case(.lose, .paper):
        return .rock
    case(.lose, .scissors):
        return .paper
    case(.win, .rock):
        return .paper
    case(.win, .paper):
        return .scissors
    case(.win, .scissors):
        return .rock
    case (.draw, _):
        return .rock // I hate that I need to do this
    }
}

// Truth Table for Results
//_|R|P|S|
//R|-|1|0|
//P|0|-|1|
//S|1|0|-|
