//
//  main.swift
//  day7
//
//  Created by Robert Stearn on 14/12/2022.
//

import Foundation

enum Type {
    case Directory
    case File
}

class Node<Value> {
    let name: Value
    let type: Type
    let size: Int
    var children: [Node]
    weak var parent: Node?

    init(_ name: Value, type: Type, size: Int = 0, children: [Node] = []) {
        self.name = name
        self.children = children
        self.type = type
        self.size = size

        for child in self.children {
            child.parent = self
        }
    }

    func add(child: Node) {
        child.parent = self
        children.append(child)
    }
    
    func recursiveSize() -> Int {
        if self.type == .File { return self.size }
        if self.children.count == 0 { return 0 }
        return self.children.map {
            $0.type == .Directory ? $0.recursiveSize() : $0.size
        }.reduce(0, +)
    }
}

//Get input data
let args = CommandLine.arguments
let rootNode = Node("/", type: .Directory)

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
            let instructions = Array(stringFromData.components(separatedBy: "\n"))
            print(instructions)
        }
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func parse(instructions: [String]) -> [String] {
    return []
}
