//
//  Menu.swift
//  littlelemon
//
//  Created by Milo Edelbi on 26.03.23.
//
import Foundation
import CoreData
import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
       
       var body: some View {
           VStack{
               Text("Little Lemon")
               Text("Chicago")
               Text("Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder")
               TextField("Search menu", text: $searchText)
               FetchedObjects(predicate: buildPredicate()) { (dishes: [Dish]) in
                   List {
                       ForEach(dishes) { dish in
                           HStack {
                               Text("\(dish.title ?? "No Data") - \(dish.price ?? "No Data")")

                               if let imageUrlString = dish.image, let imageUrl = URL(string: imageUrlString) {
                                   AsyncImage(url: imageUrl) { image in
                                       image.resizable()
                                   } placeholder: {
                                       ProgressView()
                                   }
                                   .frame(width: 50, height: 50)
                               }
                           }
                       }
                   }
               }
           }
           .onAppear{
               PersistenceController.shared.clear()
               getMenuData()
           }
       }
    
    private func getMenuData() {
        let serverURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: serverURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
                    for menuItem in fullMenu.menu {
                        let dish = Dish(context: PersistenceController.shared.container.viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.category = menuItem.category
                        print("Image URL: \(menuItem.image)")
                    }
                    try PersistenceController.shared.container.viewContext.save()
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("No data and no error")
            }
        }
        task.resume()
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
}

func buildSortDescriptors() -> [NSSortDescriptor] {
    return [NSSortDescriptor(key: "title",
                             ascending: true,
                             selector: #selector(NSString.localizedStandardCompare))]
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
