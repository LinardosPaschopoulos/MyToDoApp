//
//  MyToDoApp.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

@main
struct MyToDoAppApp: App {
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            TaskView(
                viewModel: TaskViewModel(taskService: container.taskService)
            )
        }
    }
}
