//
//  WatchSession Manager.swift
//  DrinkUp!
//
//  Created by よっちゃん on 2025/12/28.
//

import Foundation
import WatchConnectivity
import SwiftData

/*final class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()

    var modelContext: ModelContext?

    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    // Watch からメッセージを受信
    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any],
                 replyHandler: @escaping ([String : Any]) -> Void) {

        guard let context = modelContext else { return }

        // ボトル取得
        let bottles = try? context.fetch(FetchDescriptor<Bottle>())
        guard let bottle = bottles?.first else { return }

        // 記録一覧取得
        let records = (try? context.fetch(FetchDescriptor<DrinkRecord>())) ?? []

        if message["action"] as? String == "drink" {
            // 飲んだ処理
            let record = DrinkRecord(date: Date(), amount: bottle.size)
            context.insert(record)
            try? context.save()

            // HealthKit にも反映
            HealthKitManager.shared.saveWater(
                amountML: Double(bottle.size),
                date: Date()
            )
        }

        if message["action"] as? String == "status" {
            // 今日の合計を返す
            let todayTotal = records
                .filter { Calendar.current.isDateInToday($0.date) }
                .reduce(0) { $0 + $1.amount }

            replyHandler([
                "todayTotal": todayTotal,
                "bottleSize": bottle.size
            ])
        }
    }

    // 必須（中身は空でOK）
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
}
*/
