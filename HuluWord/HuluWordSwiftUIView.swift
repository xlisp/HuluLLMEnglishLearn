//
//  HuluWordSwiftUIView.swift
//  huluold
//
//  Created by Clojure on 2024/4/17.
//

import SwiftUI
import AVFoundation
import Speech

struct HuluWordSwiftUIView: View {
    @State private var huluword: String = ""
    @State private var currentWord: String = ""
    @State private var currentId: Int = 0
    @State private var wordCount: Int = 0
    @State private var words: [String] = []

    let synth = AVSpeechSynthesizer()

    private func readOut(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        print("speak: =====\(text)====")
        synth.speak(utterance)
    }

    func languageTest(sentence: String) {
        let tagger = NSLinguisticTagger(tagSchemes: [.language], options: 0)
        tagger.string = sentence
        if let language = tagger.dominantLanguage {
            print("\(language)")
        } else {
            print("Unknow.")
        }
    }

    var body: some View {
        VStack {
            if #available(iOS 14.0, *) {
                TextEditor(text: $huluword)
                    .font(.title)
                    .lineSpacing(10)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .onChange(of: huluword) { _ in
                        self.words = huluword.split { $0 == " " || $0.isNewline }.map { subString -> String in
                            return String(subString)
                        }
                        self.wordCount = words.count
                    }
            } else {
                TextField(
                    "Input hulu word:",
                    text: $huluword
                )
            }

            HStack {

                Text("Count: \(wordCount), \nCurrent: \(currentWord)") // current word can't real time
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
                // 有时候读了没听清，需要重复再读一次
                Button("Repeat", action: {
                    readOut(text: self.currentWord)
                })
                // 有时候上面一个忘了怎么读，或者点击了太快下一个，就可倒放。
                Button("<<", action: {
                    currentId = currentId - 1
                    self.currentWord = words[currentId]
                    readOut(text: self.currentWord)
                })
                // 最快速度读一遍。
                Button("Fast", action: {
                    words.forEach { word in
                        readOut(text: word)
                    }
                })                
                Button("Dict", action: {
                    let referenceVC = UIReferenceLibraryViewController(term: self.currentWord)
                    let topVC = UIApplication.getTopViewController()
                    topVC?.present(referenceVC, animated: true)
                })
            }

            HStack {
                Button(action: {
                    // 计数器模式
                    if(self.wordCount > currentId) {
                        self.currentWord = words[currentId]
                    } else {
                        // 归零重新开始。
                        currentId = 0
                        self.currentWord = words[0]
                    }
                    readOut(text: self.currentWord)
                    currentId = currentId + 1

                    // 这里会卡死。除非改成队列，不然sleep就会卡死。
                    //                words.forEach { word in
                    //                    sleep(2)
                    //                    self.currentWord = word
                    //                    readOut(text: word)
                    //                }
                    // 需要按钮大一点，常用功能。
                },label: {Text("Speak Next")
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                }
                )
            }
        }
    }
}

struct HuluWordSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HuluWordSwiftUIView()
    }
}
