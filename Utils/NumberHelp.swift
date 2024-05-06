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

func months() -> String {
    let months = """
January
February
March
April
May
June
July
August
September
October
November
December
"""
    UIPasteboard.general.string = months
    return months
}

func days() -> String {
    let days = """
Monday
Tuesday
Wednesday
Thursday
Friday
Saturday
Sunday
"""
    UIPasteboard.general.string = days
    return days
}

// TODO: 常用短句,快速读.
// 经典电影和名人采访短句快速读

