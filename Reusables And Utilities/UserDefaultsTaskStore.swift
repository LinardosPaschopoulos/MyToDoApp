//
//  UserDefaultsTaskStore.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation

final class UserDefaultsTaskStore: TaskStore {
    private let tasksKey = "todo_tasks"

    func loadTasks() -> [ToDoTask] {
        guard
            let data = UserDefaults.standard.data(forKey: tasksKey),
            let tasks = try? JSONDecoder().decode([ToDoTask].self, from: data)
        else {
            return []
        }

        return tasks
    }

    func saveTasks(_ tasks: [ToDoTask]) {
        guard let data = try? JSONEncoder().encode(tasks) else {
            return
        }

        UserDefaults.standard.set(data, forKey: tasksKey)
    }
}

protocol TaskStore {
    func loadTasks() -> [ToDoTask]
    func saveTasks(_ tasks: [ToDoTask])
}
