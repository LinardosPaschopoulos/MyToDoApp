//
//  TaskRowView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import SwiftUI

struct TaskRowView: View {
    let title: String
    let isCompleted: Bool
    let timeCreated: Date

    private var formattedDate: String {
        timeCreated.formatted(date: .abbreviated, time: .shortened)
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isCompleted ? .green : .gray)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(isCompleted ? .secondary : .primary)

                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}
