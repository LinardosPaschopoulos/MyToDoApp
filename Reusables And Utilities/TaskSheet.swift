//
//  TaskSheet.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 8/1/26.
//

import SwiftUI

struct TaskSheetView: View {
    @Binding var text: String
    
    let title: String
    let onCancel: () -> Void
    let onSave: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("", text: $text, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .lineLimit(.max)
                
                Spacer()
            }
            .padding()
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: onCancel)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: onSave)
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
