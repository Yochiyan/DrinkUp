//
//  ContentView.swift
//  How many drink water?
//
//  Created by よっちゃん on 2025/09/18.
//

import SwiftUI
import SwiftData
import Combine

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var bottles: [Bottle]
    @Query private var records: [DrinkRecord]
    @State private var inputSize = ""
    @State private var today = Date()
    @State private var now: Date = Date()
    
    // 自販機価格（固定）
    let vendingPricePer = 120
    let vendingSize = 540
    
    var body: some View {
        VStack(spacing: 50) {
            if let bottle = bottles.first {
                Text("ボトル容量: \(bottle.size) ml")
                    .font(.title)
                    .fontWeight(.bold)
                
                // 今日の合計
                Text("今日の合計: \(todayTotal()) ml")
                    .font(.headline)
                    .onReceive(Timer.publish(every: 60, on: .main, in: .common).autoconnect()) { value in
                        now = value
                        today = value // keep “today” refreshed
                    }
                
                // 累計
                let total = records.reduce(0) { $0 + $1.amount }
                Text("累計: \(total) ml")
                    .font(.headline)
                
                // 節約額
                let saving = total * vendingPricePer / vendingSize
                Text("累計節約額: ¥\(saving)")//いろはす540mlと比較して。
                    .font(.headline)
                
                Button(action: {
                    let newRecord = DrinkRecord(date: Date(), amount: bottle.size)
                    context.insert(newRecord)
                    try? context.save()
                }) {
                    Text("飲み切った！")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 履歴リスト（簡易）
                List(records) { record in
                    VStack(alignment: .leading) {
                        Text("\(record.amount) ml")
                            .fontWeight(.bold)
                        Text(record.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
            } else {
                // 初回入力
                VStack(spacing: 30) {
                    Text("こんにちは！")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("水分補給量を簡単に記録できます！")
                        .font(.title2)
                        .padding(16)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                    
                    
                }
                .padding(80)
                .background(
                    
                    LinearGradient(
                        
                        gradient: Gradient(colors: [Color.blue, Color.white]),
                        startPoint: .top, endPoint: .bottom
                        
                    )
                    .cornerRadius(40) // ビューの角を丸くする。
                        .padding(16) // 余白を追加
                        .shadow(radius: 10) // ビューに影を追加
                )
                Text("ボトル容量(ml)を入力してください")
                TextField("300", text: $inputSize)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                Button("保存") {
                    if let size = Int(inputSize) {
                        let newBottle = Bottle(size: size)
                        context.insert(newBottle)
                        try? context.save()
                        
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        // アプリがフォアグラウンドに戻ったら日付を更新
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            today = Date()
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged)) { _ in
            today = Date()
        }
    }
    
    // 今日の合計を算出
    private func todayTotal() -> Int {
        let cal = Calendar.current
        let start = cal.startOfDay(for: today)
        guard let end = cal.date(byAdding: .day, value: 1, to: start) else { return 0 }
        return records
            .filter { $0.date >= start && $0.date < end }
            .reduce(0) { $0 + $1.amount }
    }
    
}
#Preview {
    ContentView()
        .modelContainer(for: [Bottle.self, DrinkRecord.self], inMemory: true)
}
