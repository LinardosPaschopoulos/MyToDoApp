//
//  TaskCoordinating.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Combine

protocol TaskCoordinator: AnyObject {
    func showAddTask()
    func showEditTask(task: TaskModel)
    func dismiss()
}

@MainActor
final class DefaultTaskCoordinator: ObservableObject, TaskCoordinator {
    @Published var isShowingAddTask = false
    @Published var editingTask: TaskModel?

    func showAddTask() {
        isShowingAddTask = true
    }

    func showEditTask(task: TaskModel) {
        editingTask = task
    }

    func dismiss() {
        isShowingAddTask = false
        editingTask = nil
    }
}
