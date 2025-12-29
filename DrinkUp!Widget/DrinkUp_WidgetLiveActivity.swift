//
//  DrinkUp_WidgetLiveActivity.swift
//  DrinkUp!Widget
//
//  Created by よっちゃん on 2025/12/29.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DrinkUp_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DrinkUp_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DrinkUp_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DrinkUp_WidgetAttributes {
    fileprivate static var preview: DrinkUp_WidgetAttributes {
        DrinkUp_WidgetAttributes(name: "World")
    }
}

extension DrinkUp_WidgetAttributes.ContentState {
    fileprivate static var smiley: DrinkUp_WidgetAttributes.ContentState {
        DrinkUp_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DrinkUp_WidgetAttributes.ContentState {
         DrinkUp_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DrinkUp_WidgetAttributes.preview) {
   DrinkUp_WidgetLiveActivity()
} contentStates: {
    DrinkUp_WidgetAttributes.ContentState.smiley
    DrinkUp_WidgetAttributes.ContentState.starEyes
}
