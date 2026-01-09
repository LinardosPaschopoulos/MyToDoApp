//
//  AppContainer.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation

final class AppContainer {
    let taskService: TaskService

    init(taskService: TaskService = UserDefaultsTaskService()) {
        self.taskService = taskService
    }
}
