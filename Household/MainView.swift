//
//  MainView.swift
//  Household
//
//  Created by 長橋和敏 on 2025/02/11.
//

// 4. メイン画面（MainView.swift）
// ここでは、Core Data から取得した記録を月ごとにグループ化してリスト表示し、
// 各月の合計金額を表示しています。

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // 日付降順でレコードをフェッチ
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.date, ascending: false)],
        animation: .default)
    private var records: FetchedResults<Record>

    var body: some View {
        NavigationView {
            List {
                // グループ化: 日付（"yyyy年MM月"）ごとにまとめる
                ForEach(groupedRecords.keys.sorted(by: >), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedRecords[key] ?? []) { record in
                            HStack {
                                Text(record.type ?? "").foregroundColor(record.type == "Expense" ? .red : .green)
                                Spacer()
                                Text("\(record.amount, specifier: "%.2f") 円")
                            }
                        }
                        if let total = monthlyTotal(for: groupedRecords[key] ?? []){
                                    HStack {
                                        Spacer()
                                        Text("合計: \(total, specifier: "%.2f") 円").fontWeight(.bold)
                                    }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("家計簿")
            .toolbar {
                // 入力画面へのリンク
                NavigationLink(destination: AddRecordView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    // 記録を "yyyy年MM月" でグループ化
    private var groupedRecords: [String: [Record]] {
        Dictionary(grouping: records) { record in
            let date = record.date ?? Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月"
            return formatter.string(from: date)
        }
    }
                                     
    // 指定されたレコード群の合計を計算
    private func monthlyTotal(for record: [Record]) -> Double? {
                                    record.map { $0.amount }.reduce(0, +)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
