//
//  ContentView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedTasks) { task in
                    TaskRowView(
                        title: task.title,
                        isCompleted: task.isCompleted,
                        timeCreated: task.createdAt
                    )
                    .onTapGesture {
                        viewModel.didSelectTask(task)
                    }
                }
                .onDelete(perform: viewModel.didDeleteTask)
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
