//
//  CoreDataService.swift
//  ToDoListWithCoreData
//
//  Created by Erma on 31/7/24.
//

import UIKit
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addTasks(id: String, title: String) {
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let task  = Task(entity: taskEntity, insertInto: context)
        task.id = id
        task.title = title
        appDelegate.saveContext()
    }
    
    func fetchTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            return try context.fetch(fetchRequest) as! [Task]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateTasks(id: String,
                     title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let tasks =  try context.fetch(fetchRequest) as? [Task],
                  let task = tasks.first(where: { $0.id == id }) else { return }
            task.title = title
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteTask(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do{
            guard let tasks = try context.fetch(fetchRequest) as? [Task],
                  let task = tasks.first(where: { $0.id == id })else { return }
            context.delete(task)
        }catch{
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteTasks(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            guard let tasks = try context.fetch(fetchRequest) as? [Task] else{ return }
            tasks.forEach{ task in
                context.delete(task)
            }
        }catch{
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
}
