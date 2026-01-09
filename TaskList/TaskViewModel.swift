//
//  TaskListViewModel.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import SwiftUI
import Combine

@MainActor
final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskModel] = []
    @Published var newTaskTitle = ""
    @Published var editedTaskTitle = ""
    @Published var editingTask: TaskModel?

    private let taskService: TaskService

    var sortedTasks: [TaskModel] {
        tasks.sorted { $0.createdAt < $1.createdAt }
    }

    init(taskService: TaskService) {
        self.taskService = taskService
        loadTasks()
    }

    func didTapSaveTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        tasks.append(TaskModel(id: UUID(), title: trimmed, isCompleted: false, createdAt: Date()))
        persist()
        newTaskTitle = ""
    }

    func didTapCancelAdd() {
        newTaskTitle = ""
    }

    func didRequestEdit(_ task: TaskModel) {
        editingTask = task
        editedTaskTitle = task.title
    }

    func didSaveEdit() {
        guard
            let task = editingTask,
            let index = tasks.firstIndex(of: task)
        else { return }

        let trimmed = editedTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        tasks[index] = TaskModel(
            id: task.id,
            title: trimmed,
            isCompleted: task.isCompleted,
            createdAt: task.createdAt
        )

        clearEditingState()
        persist()
    }

    func didCancelEdit() {
        clearEditingState()
    }

    private func clearEditingState() {
        editingTask = nil
        editedTaskTitle = ""
    }

    func didSelectTask(_ task: TaskModel) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks[index].isCompleted.toggle()
        persist()
    }

    func didDeleteTask(ids: Set<UUID>) {
        tasks.removeAll { ids.contains($0.id) }
        persist()
    }

    private func loadTasks() {
        tasks = taskService.loadTasks()
    }

    private func persist() {
        taskService.saveTasks(tasks)
    }
}
