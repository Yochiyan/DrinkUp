//
//  BottleEditView.swift
//  How many drink water?
//
//  Created by よっちゃん on 2025/09/29.
//
import SwiftUI
import SwiftData

struct BottleEditView: View {
    @Environment(\.modelContext) private var context
    @Bindable var bottle: Bottle
    @State private var inputSize: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ボトル容量を変更")
                .font(.title2)
            
            TextField("ml", text: $inputSize)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
            
            Button("保存") {
                if let size = Int(inputSize) {
                    bottle.size = size
                    try? context.save()
                    dismiss()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            inputSize = "\(bottle.size)"
        }
    }
}

#Preview {
    let sampleBottle = Bottle(size: 500)
    BottleEditView(bottle: sampleBottle)
        .modelContainer(for: [Bottle.self], inMemory: true)
}

