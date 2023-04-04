import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()

        do {
            let dishes = try container.viewContext.fetch(fetchRequest)
            for dish in dishes {
                container.viewContext.delete(dish)
            }
            try container.viewContext.save()
            print("Cleared dishes")
        } catch let error {
            print("Error clearing dishes: \(error.localizedDescription)")
        }
    }

}
