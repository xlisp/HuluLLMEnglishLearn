//
//  ParseMarkdownNewWord.swift
//  HuluWord
//
//  Created by Clojure on 2024/4/26.
//

import Foundation

// Reading input from standard input
//let input = {
//    () -> [String] in
//    var lines: [String] = []
//    while let line = readLine() {
//        lines.append(line)
//    }
//    return lines
//}()

let input = ["Note that Swift infers a type of String for the someString constant because it’s initialized with a string literal value.", "To make a multiline string literal that begins or ends with a line feed, write a blank line as the first or last line", "String literals can include the following special characters"]

// Reading knowed-word.txt file
//guard let knowedWordFileURL = URL(string: "/Users/clojure/Documents/_think_different_everday/knowed-word.txt"),
//      let knowedWordString = try? String(contentsOf: knowedWordFileURL) else {
//    fatalError("Failed to read knowed-word.txt")
//}

let knowedWordString = """
word
work
working
world
would
write
writing
xml
yarn
years
you
"""

// $ swift repl => test this code is work
func printNewWord(knowedWordString: String, input: [String]) {
    // Parsing knowed words
    let knowedWords = Set(knowedWordString.lowercased().components(separatedBy: .newlines))
    
    // Parsing every word from input
    let everyWord = input
        .flatMap { $0.components(separatedBy: CharacterSet(charactersIn: " .)/(/\",:[];_-@*：")) }
        .filter { $0.rangeOfCharacter(from: .letters) != nil }
        .map { $0.lowercased() }
        .filter { !knowedWords.contains($0) }

    // Printing every word
    everyWord.forEach { print($0) }
}
