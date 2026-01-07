//
//  TaskListViewModel.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation
import Combine
import SwiftUI

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [ToDoTask] = []
    @Published var isShowingAddTask = false
    @Published var newTaskTitle = ""

    var sortedTasks: [ToDoTask] {
        tasks.sorted { $0.createdAt < $1.createdAt }
    }
    
    init() {
        loadMockData()
    }

    func didTapAdd() {
        isShowingAddTask = true
    }

    func didTapCancelAdd() {
        dismissAddTask()
    }

    func didTapSaveTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        tasks.append(
            ToDoTask(
                title: trimmed,
                isCompleted: false,
                createdAt: Date()
            )
        )

        dismissAddTask()
    }

    func didSelectTask(_ task: ToDoTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        tasks[index].isCompleted.toggle()
    }

    func didDeleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    private func dismissAddTask() {
        newTaskTitle = ""
        isShowingAddTask = false
    }

    private func loadMockData() {
        tasks = [
            ToDoTask(
                title: "Buy groceries",
                isCompleted: false,
                createdAt: Date().addingTimeInterval(-3600)
            ),
            ToDoTask(
                title: "Read SwiftUI docs",
                isCompleted: true,
                createdAt: Date().addingTimeInterval(-7200)
            ),
            ToDoTask(
                title: "Refactor ViewModels",
                isCompleted: false,
                createdAt: Date()
            )
        ]
    }
}
