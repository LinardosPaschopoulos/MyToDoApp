//
//  AppContainer.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation

final class AppContainer {
    let taskStore: TaskStore

    init(taskStore: TaskStore = UserDefaultsTaskStore()) {
        self.taskStore = taskStore
    }
}
