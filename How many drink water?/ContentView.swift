//
//  ContentView.swift
//  How many drink water?
//
//  Created by よっちゃん on 2025/09/18.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var bottles: [Bottle]
    @Query private var records: [DrinkRecord]
   
    @State private var inputSize = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if let bottle = bottles.first {
                Text("ボトル容量: \(bottle.size) ml")
                    .font(.title)
                
                // 今日の合計
                Text("今日の合計: \(todayTotal()) ml")
                    .font(.headline)
                
                // 累計
                Text("累計: \(records.reduce(0) { $0 + $1.amount }) ml")
                    .font(.headline)
                
                Button(action: {
                    let newRecord = DrinkRecord(date: Date(), amount: bottle.size)
                    context.insert(newRecord)
                    try? context.save()
                }) {
                    Text("飲んだ！ (\(bottle.size)ml)")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 履歴リスト（簡易）
                List(records) { record in
                    VStack(alignment: .leading) {
                        Text("\(record.amount) ml")
                        Text(record.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
            } else {
                // 初回入力
                Text("ボトル容量を入力してください")
                TextField("例: 500", text: $inputSize)
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
    }
    
    // 今日の合計を算出
    private func todayTotal() -> Int {
        let calendar = Calendar.current
        return records.filter { calendar.isDateInToday($0.date) }
                      .reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Bottle.self, DrinkRecord.self], inMemory: true)
}
