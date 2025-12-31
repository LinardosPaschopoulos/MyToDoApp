//
//  ContentView.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 31/12/25.
//

import SwiftUI

struct TaskRowView: View {
    let title: String
    let isCompleted: Bool
    let timeCreated: Date

    private var formattedDate: String {
        timeCreated.formatted(date: .abbreviated, time: .shortened)
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isCompleted ? .green : .gray)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(isCompleted ? .secondary : .primary)

                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

struct ToDoTask: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool
    let timeCreated: Date
}

struct TaskListView: View {
    @State private var isShowingAddTask = false
    @State private var newTaskTitle = ""
    @State private var tasks: [ToDoTask] = [
        ToDoTask(
            title: "Buy groceries",
            isCompleted: false,
            timeCreated: Date().addingTimeInterval(-3600)
        ),
        ToDoTask(
            title: "Read SwiftUI docs",
            isCompleted: true,
            timeCreated: Date().addingTimeInterval(-7200)
        ),
        ToDoTask(
            title: "Refactor ViewModels",
            isCompleted: false,
            timeCreated: Date()
        )
    ]
    
    var sortedTasks: [ToDoTask] {
        tasks.sorted { $0.timeCreated < $1.timeCreated }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedTasks) { task in
                    TaskRowView(
                        title: task.title,
                        isCompleted: task.isCompleted,
                        timeCreated: task.timeCreated
                    )
                    .onTapGesture {
                        toggle(task)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTask) {
                NavigationStack {
                    VStack(spacing: 16) {
                        TextField("Task description", text: $newTaskTitle)
                            .textFieldStyle(.roundedBorder)

                        Spacer()
                    }
                    .padding()
                    .navigationTitle("New Task")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismissAddTask()
                            }
                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                saveNewTask()
                            }
                            .disabled(newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }
            }
        }
    }
    
    func saveNewTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        tasks.append(
            ToDoTask(
                title: trimmed,
                isCompleted: false,
                timeCreated: Date()
            )
        )

        dismissAddTask()
    }

    func dismissAddTask() {
        newTaskTitle = ""
        isShowingAddTask = false
    }
}

private extension TaskListView {

    func toggle(_ task: ToDoTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        tasks[index].isCompleted.toggle()
    }

    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func addMockTask() {
        tasks.append(
            ToDoTask(title: "New Task \(tasks.count + 1)", isCompleted: false, timeCreated: Date())
        )
    }
}
