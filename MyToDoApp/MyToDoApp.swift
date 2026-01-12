//
//  MyToDoApp.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

@main
struct MyToDoApp: App {
    var body: some Scene {
        WindowGroup {
            let service = UserDefaultsTaskService()
            let coordinator = DefaultTaskCoordinator()
            let viewModel = TaskViewModel(taskService: service, coordinator: coordinator)

            TaskView(viewModel: viewModel)
        }
    }
}
