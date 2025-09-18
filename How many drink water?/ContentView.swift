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
    
    
    // 自販機価格（固定）
    let vendingPricePer500ml = 130
    let vendingSize = 540
    
    var body: some View {
        VStack(spacing: 20) {
            if let bottle = bottles.first {
                Text("ボトル容量: \(bottle.size) ml")
                    .font(.title)
                
                // 今日の合計
                Text("今日の合計: \(todayTotal()) ml")
                    .font(.headline)
                
                // 累計
                let total = records.reduce(0) { $0 + $1.amount }
                Text("累計: \(total) ml")
                    .font(.headline)
                
                // 節約額
                let saving = total * vendingPricePer500ml / vendingSize
                Text("累計節約額: ¥\(saving)")//いろはす540mlと比較して。
                    .font(.headline)
                
                Button(action: {
                    let newRecord = DrinkRecord(date: Date(), amount: bottle.size)
                    context.insert(newRecord)
                    try? context.save()
                }) {
                    Text("飲み切った！")
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
                Text("ボトル容量(ml)を入力してください")
                TextField("例: 300", text: $inputSize)
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
