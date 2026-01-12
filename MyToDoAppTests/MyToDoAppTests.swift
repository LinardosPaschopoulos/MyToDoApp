//
//  MyToDoAppTests.swift
//  MyToDoAppTests
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import XCTest
@testable import MyToDoApp

@MainActor
final class TaskListViewModelTests: XCTestCase {
    var viewModel: TaskViewModel!
    var mockStore: MockTaskService!

    override func setUp() {
        super.setUp()
        mockStore = MockTaskService()
    }

    override func tearDown() {
        viewModel = nil
        mockStore = nil
        super.tearDown()
    }

    func testAddTask() {
        viewModel = TaskViewModel(taskService: mockStore)
        XCTAssertTrue(viewModel.sortedTasks.isEmpty)
        viewModel.newTaskTitle = "Test Task"
        viewModel.didTapSaveTask()

        XCTAssertEqual(viewModel.sortedTasks.count, 1)
        XCTAssertEqual(viewModel.sortedTasks[0].title, "Test Task")
        XCTAssertFalse(viewModel.sortedTasks[0].isCompleted)
        XCTAssertEqual(mockStore.savedTasks.count, 1)
    }

    func testEditTask() {
        let task = TaskModel(id: UUID(), title: "Old Title", isCompleted: false, createdAt: Date())
        mockStore.savedTasks = [task]

        viewModel = TaskViewModel(taskService: mockStore)
        viewModel.didRequestEdit(task)
        viewModel.editedTaskTitle = "New Title"
        viewModel.didSaveEdit()

        XCTAssertEqual(viewModel.sortedTasks[0].title, "New Title")
        XCTAssertEqual(mockStore.savedTasks[0].title, "New Title")
    }
}
