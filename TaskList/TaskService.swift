//
//  TaskListService.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Foundation

protocol TaskService {
    func loadTasks() -> [TaskModel]
    func saveTasks(_ tasks: [TaskModel])
}

final class UserDefaultsTaskService: TaskService {
    private let key = "tasks"

    func loadTasks() -> [TaskModel] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let tasks = try? JSONDecoder().decode([TaskModel].self, from: data)
        else {
            return []
        }
        return tasks
    }

    func saveTasks(_ tasks: [TaskModel]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: key)
    }
}
