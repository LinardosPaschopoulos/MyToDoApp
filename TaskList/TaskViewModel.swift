//
//  TaskListViewModel.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation
import Combine

final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskModel] = []
    @Published var newTaskTitle = ""
    @Published var editedTaskTitle = ""
    @Published var editingTask: TaskModel?
    @Published var isShowingAddTask = false

    private let taskService: TaskService
    private weak var coordinator: TaskCoordinator?

    var sortedTasks: [TaskModel] {
        tasks.sorted { $0.createdAt < $1.createdAt }
    }

    init(taskService: TaskService, coordinator: TaskCoordinator? = nil) {
        self.taskService = taskService
        self.coordinator = coordinator
        loadTasks()
    }

    func didTapAdd() {
        isShowingAddTask = true
    }

    func didTapCancelAdd() {
        newTaskTitle = ""
        isShowingAddTask = false
        coordinator?.didCancelAdd()
    }

    func didTapSaveTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let task = TaskModel(id: UUID(), title: trimmed, isCompleted: false, createdAt: Date())
        tasks.append(task)
        persist()

        newTaskTitle = ""
        isShowingAddTask = false
        coordinator?.didFinishAdd()
    }

    func didRequestEdit(_ task: TaskModel) {
        editingTask = task
        editedTaskTitle = task.title
        coordinator?.didStartEdit(task: task)
    }

    func didCancelEdit() {
        clearEditingState()
        coordinator?.didCancelEdit()
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
        persist()
        clearEditingState()
        coordinator?.didFinishEdit()
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

    private func clearEditingState() {
        editingTask = nil
        editedTaskTitle = ""
    }

    private func loadTasks() {
        tasks = taskService.loadTasks()
    }

    private func persist() {
        taskService.saveTasks(tasks)
    }
}
