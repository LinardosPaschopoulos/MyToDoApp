//
//  ToDoTask.swift
//  MyToDoApp
//
//  Created by Linardos Paschopoulos  on 7/1/26.
//

import Foundation

struct ToDoTask: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    var isCompleted: Bool
    let createdAt: Date
}
