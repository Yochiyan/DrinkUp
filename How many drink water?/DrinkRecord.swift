//
//  DrinkRecord.swift
//  How many drink water?
//
//  Created by よっちゃん on 2025/09/18.
//

import Foundation
import SwiftData

@Model
class DrinkRecord {
    var date: Date
    var amount: Int
    
    init(date: Date, amount: Int) {
        self.date = date
        self.amount = amount
    }
}
