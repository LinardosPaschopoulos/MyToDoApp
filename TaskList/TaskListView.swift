//
//  ContentView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel: TaskListViewModel

    init(viewModel: TaskListViewModel) {
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
            .sheet(isPresented: $viewModel.isShowingAddTask) {
                addTaskSheet
            }
        }
    }

    private var taskListView: some View {
        List {
            ForEach(viewModel.sortedTasks) { task in
                TaskRowView(task: task)
                    .onTapGesture {
                        viewModel.didSelectTask(task)
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
            Spacer()
        }
    }

    private var addTaskSheet: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Task description", text: $viewModel.newTaskTitle)
                    .textFieldStyle(.roundedBorder)

                Spacer()
            }
            .padding()
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.didTapCancelAdd()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.didTapSaveTask()
                    }
                    .disabled(
                        viewModel.newTaskTitle
                            .trimmingCharacters(in: .whitespaces)
                            .isEmpty
                    )
                }
            }
        }
    }
}
