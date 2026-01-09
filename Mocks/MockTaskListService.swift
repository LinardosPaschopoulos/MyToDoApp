//
//  MockTaskListService.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Foundation

@MainActor
final class MockTaskListService: TaskService {
    var savedTasks: [TaskModel] = []

    func loadTasks() -> [TaskModel] {
        savedTasks
    }

    func saveTasks(_ tasks: [TaskModel]) {
        savedTasks = tasks
    }
}
