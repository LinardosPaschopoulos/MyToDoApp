//
//  MockTaskCoordinator.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Foundation

final class MockTaskCoordinator: TaskCoordinator {
    var didShowAddTask = false
    var didShowEditTask: TaskModel?

    func showAddTask() {
        didShowAddTask = true
    }

    func showEditTask(task: TaskModel) {
        didShowEditTask = task
    }

    func dismiss() { }
}
