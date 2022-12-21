//
//  main.swift
//  day7
//
//  Created by Robert Stearn on 14/12/2022.
//

import Foundation

enum NodeType {
    case Directory
    case File
}

class Node {
    let name: String
    let type: NodeType
    var size: Int
    var children: [Node]
    weak var parent: Node?

    init(_ name: String, type: NodeType, size: Int = 0, children: [Node] = []) {
        self.name = name
        self.children = children
        self.type = type
        self.size = size

        for child in children {
            self.add(child: child)
        }
    }

    func add(child: Node) {
        child.parent = self
        children.append(child)
        self.size += child.size
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
var activeNode = rootNode

//Fail on no file
if args.count < 2 {
    print("No input file specified.")
} else {
    let path = args[1]
    let fileURL = URL(filePath: path)
    
    do {//Getting the contents of the file if the file is parsable
        let fileData = try Data(contentsOf: fileURL)
        if let stringFromData = String(data: fileData, encoding: .utf8) {
            let instructions = Array(stringFromData.components(separatedBy: "\n"))
            parse(instructions: instructions)
            print(activeNode)
        }
    } catch {
        print("ERROR: Could not read data from the file at: " + path)
    }
}

func parse(instructions: [String]) -> Void {
    for instruction in instructions {
        let instructionElements = Array(instruction.components(separatedBy: " "))
        if !instructionElements[0].isEmpty {
            switch instructionElements[0] {
            case "$":
                switch instructionElements[1] {
                case "cd":
//                    print("Change directory to " + instructionElements[2])
                    //Change current active node
                    //look for matching active node
                    if instructionElements[2] == ".." {
                        activeNode = activeNode.parent ?? activeNode
                    }
                    if (activeNode.name != instructionElements[2]) {
                        let newActiveNode = activeNode.children.first( where: { $0.name == instructionElements[2] })
                        activeNode = newActiveNode ?? activeNode
                    }
                    //look for match in children
//                case "ls":
//                    print("List directory contents...")
                    //Enable create mode OR do nothing and assume that every output entry == a create statement HMMMM 🤔
                default:
                    print("--------")
                }
                
            case "dir":
//                print("Directory - " + instructionElements[1])
                //Create a Directory Node
                let directoryNode = Node(instructionElements[1], type: .Directory)
                activeNode.add(child: directoryNode)
            default:
//                print("File - " + instructionElements[1] + ", Size - " + instructionElements[0])
                //Create File Node
                let fileNode = Node(instructionElements[1], type: .File, size: Int(instructionElements[0]) ?? 0)
                activeNode.add(child: fileNode)
            }
        }
    }

}

func traverseTreeFrom(node: Node) -> Int {
    return 0
}
