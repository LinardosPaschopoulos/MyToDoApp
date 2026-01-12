//
//  ContentView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

struct TaskView: View {
    @StateObject private var viewModel: TaskViewModel

    init(viewModel: TaskViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.sortedTasks.isEmpty {
                    emptyStateView
                } else {
                    taskListView
                }
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.didTapAdd()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingAddTask) {
            TaskSheetView(
                text: $viewModel.newTaskTitle,
                title: "New Task",
                onCancel: { viewModel.didTapCancelAdd() },
                onSave: { viewModel.didTapSaveTask() }
            )
        }
        .sheet(item: $viewModel.editingTask) { _ in
            TaskSheetView(
                text: $viewModel.editedTaskTitle,
                title: "Edit Task",
                onCancel: { viewModel.didCancelEdit() },
                onSave: { viewModel.didSaveEdit() }
            )
        }
    }

    private var taskListView: some View {
        List {
            ForEach(viewModel.sortedTasks) { task in
                TaskRowView(task: task)
                    .onTapGesture { viewModel.didSelectTask(task) }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.didRequestEdit(task)
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }.tint(.blue)
                    }
            }
            .onDelete { offsets in
                let ids = offsets.map { viewModel.sortedTasks[$0].id }
                viewModel.didDeleteTask(ids: Set(ids))
            }
        }
        .listStyle(.plain)
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "checklist")
                .font(.system(size: 64))
                .foregroundColor(.secondary)
            Text("No Tasks")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Tap + to add your first task")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}
