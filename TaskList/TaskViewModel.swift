//
//  TaskListViewModel.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Combine
import Foundation

final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskModel] = []
    @Published var isShowingAddTask = false
    @Published var newTaskTitle = ""
    @Published var editingTask: TaskModel?
    @Published var editedTaskTitle = ""

    private let taskService: TaskService

    var sortedTasks: [TaskModel] {
        tasks.sorted { $0.createdAt < $1.createdAt }
    }

    init(taskService: TaskService) {
        self.taskService = taskService
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
            TaskModel(
                id: UUID(),
                title: trimmed,
                isCompleted: false,
                createdAt: Date()
            )
        )

        persist()
        dismissAddTask()
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

    func didRequestEdit(_ task: TaskModel) {
        editingTask = task
        editedTaskTitle = task.title
    }

    func didCancelEdit() {
        editingTask = nil
        editedTaskTitle = ""
    }

    func didSaveEdit() {
        guard
            let task = editingTask,
            let index = tasks.firstIndex(of: task)
        else { return }

        let trimmed = editedTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        tasks[index] = TaskModel(
            id: task.id,
            title: trimmed,
            isCompleted: task.isCompleted,
            createdAt: task.createdAt
        )
        
        persist()
        didCancelEdit()
    }

    private func loadTasks() {
        tasks = taskService.loadTasks()
    }

    private func persist() {
        taskService.saveTasks(tasks)
    }

    private func dismissAddTask() {
        newTaskTitle = ""
        isShowingAddTask = false
    }
}
