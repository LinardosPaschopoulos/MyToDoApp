//
//  TaskCoordinator.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 9/1/26.
//

import Foundation

protocol TaskCoordinator: AnyObject {
    func didStartEdit(task: TaskModel)
    func didFinishEdit()
    func didCancelEdit()
    func didFinishAdd()
    func didCancelAdd()
}

final class DefaultTaskCoordinator: TaskCoordinator {
    func didStartEdit(task: TaskModel) { print("Started editing \(task.title)") }
    func didFinishEdit() { print("Finished editing") }
    func didCancelEdit() { print("Cancelled editing") }
    func didFinishAdd() { print("Finished adding task") }
    func didCancelAdd() { print("Cancelled adding task") }
}
