//
//  AddRecordView.swift
//  Household
//
//  Created by 長橋和敏 on 2025/02/11.
//

// 5. 入力画面（AddRecordView.swift）
// ここでは、TextField（数値入力）、Picker（収入か支出かの選択）、DatePicker（日付選択）を
// 利用して新規記録を追加します。

import SwiftUI

struct AddRecordView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedType = "Income"
    @State private var amountText = ""
    @State private var selectedDate = Date()
    
    let types = ["Income", "Expense"]
    
    var body: some View {
        Form {
            Section(header: Text("タイプ")) {
                Picker("タイプ", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type == "Income" ? "収入" : "支出")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("金額")) {
                TextField("金額を入力", text: $amountText)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("日付")) {
                DatePicker("日付を選択", selection: $selectedDate, displayedComponents: .date)
            }
            
            Button(action: saveRecord) {
                HStack {
                    Spacer()
                    Text("保存")
                        .fontWeight(.bold)
                    Spacer()
                }
            }
        }
        .navigationTitle("記録の追加")
    }
    
    private func saveRecord() {
        // 数値変換に失敗した場合は何もしない
        guard let amount = Double(amountText) else { return }
        
        let newRecord = Record(context: viewContext)
        newRecord.id = UUID()
        newRecord.type = selectedType
        newRecord.amount = amount
        newRecord.date = selectedDate
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("記録の保存に失敗: \(error)")
        }
    }
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}
