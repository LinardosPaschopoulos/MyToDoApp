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
    @Published private(set) var tasks: [ToDoTask] = []
    @Published var isShowingAddTask = false
    @Published var newTaskTitle = ""
    
    private let taskStore: TaskStore
    var sortedTasks: [ToDoTask] {
        tasks.sorted { $0.createdAt < $1.createdAt }
    }

    init(taskStore: TaskStore) {
        self.taskStore = taskStore
        loadTasks()
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
                id: UUID(),
                title: trimmed,
                isCompleted: false,
                createdAt: Date()
            )
        )

        persist()
        dismissAddTask()
    }

    func didSelectTask(_ task: ToDoTask) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks[index].isCompleted.toggle()
        persist()
    }

    func didDeleteTask(ids: Set<UUID>) {
        tasks.removeAll { ids.contains($0.id) }
        persist()
    }

    private func loadTasks() {
        tasks = taskStore.loadTasks()
    }

    private func persist() {
        taskStore.saveTasks(tasks)
    }

    private func dismissAddTask() {
        newTaskTitle = ""
        isShowingAddTask = false
    }
}
