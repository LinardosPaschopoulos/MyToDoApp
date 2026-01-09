//
//  MockTaskStore.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 8/1/26.
//

import Foundation

@MainActor
final class MockTaskStore: TaskStore {
    var savedTasks: [ToDoTask] = []
    
    func loadTasks() -> [ToDoTask] {
        return savedTasks
    }
    
    func saveTasks(_ tasks: [ToDoTask]) {
        savedTasks = tasks
    }
}
