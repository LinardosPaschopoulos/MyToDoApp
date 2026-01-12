//
//  MockTaskCoordinator.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Foundation

@MainActor
final class MockTaskCoordinator: TaskCoordinator {
    var startedEdit: TaskModel?
    var finishedEditCalled = false
    var canceledEditCalled = false
    var finishedAddCalled = false
    var canceledAddCalled = false

    func didStartEdit(task: TaskModel) {
        startedEdit = task
    }

    func didFinishEdit() {
        finishedEditCalled = true
    }

    func didCancelEdit() {
        canceledEditCalled = true
    }

    func didFinishAdd() {
        finishedAddCalled = true
    }

    func didCancelAdd() {
        canceledAddCalled = true
    }
}
