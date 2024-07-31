//
//  ToDoListViewModel.swift
//  ToDoListWithCoreData
//
//  Created by Erma on 31/7/24.
//

import Foundation
import Combine

class ToDoListViewModel: ObservableObject {
    @Published var title = ""
    @Published var tasks: [Task] = []

    private let coreDataService = CoreDataService.shared
    private var cancellables: Set<AnyCancellable> = []
    private var task: Task?

    init(task: Task? = nil) {
        self.task = task
        if let task = task {
            self.title = task.title ?? ""
        }
        fetchTasks()
    }

    func fetchTasks() {
        tasks = coreDataService.fetchTasks()
    }

    func saveNote() {
        if let task = task {
            coreDataService.updateTasks(id: task.id ?? "", title: title)
        } else {
            coreDataService.addTasks(id: UUID().uuidString, title: title)
        }
        fetchTasks()
    }

    func deleteNoteById(_ id: String) {
           coreDataService.deleteTask(id: id)
           fetchTasks()
       }
    
    func deleteTasks() {
        coreDataService.deleteTasks()
        fetchTasks()
    }
}
