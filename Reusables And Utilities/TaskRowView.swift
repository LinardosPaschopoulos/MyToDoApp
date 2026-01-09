//
//  TaskRowView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import SwiftUI

struct TaskRowView: View {
    let task: ToDoTask
    
    private var formattedDate: String {
        task.createdAt.formatted(date: .long, time: .shortened)
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .taskGreen : .taskGray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .strikethrough(task.isCompleted, color: .taskSecondary)
                    .foregroundColor(task.isCompleted ? .taskSecondary : .taskPrimary)
                
                Text("Created at " + formattedDate)
                    .font(.caption)
                    .foregroundColor(.taskSecondary)
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(task.title), " +
            "\(task.isCompleted ? "completed" : "not completed"), " +
            "created on \(formattedDate)"
        )
        .accessibilityHint("Tap to toggle completion")
        .accessibilityAddTraits(.isButton)
    }
}

