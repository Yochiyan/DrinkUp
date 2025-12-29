//
//  DrinkUp_WidgetBundle.swift
//  DrinkUp!Widget
//
//  Created by よっちゃん on 2025/12/29.
//

import WidgetKit
import SwiftUI

@main
struct DrinkUp_WidgetBundle: WidgetBundle {
    var body: some Widget {
        DrinkUp_Widget()
        DrinkUp_WidgetControl()
        DrinkUp_WidgetLiveActivity()
    }
}
