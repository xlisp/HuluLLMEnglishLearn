//
//  NumberHelp.swift
//  HuluWord
//
//  Created by Clojure on 2024/5/6.
//

import Foundation
import UIKit

// (run! prn (range 11 20))
func eleven2nineteen() -> String {
    let numbers = """
11
12
13
14
15
16
17
18
19
"""
    UIPasteboard.general.string = numbers
    return numbers
}

func ten2onehundred() -> String {
    let numbers = """
10
20
30
40
50
60
70
80
90
100
"""
    UIPasteboard.general.string = numbers
    return numbers
}
