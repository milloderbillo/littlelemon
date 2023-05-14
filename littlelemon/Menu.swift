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
           VStack(spacing: 0){
               ZStack{
                   HStack{
                       Spacer()
                       Image("Profile")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 60)
                   }
                   .padding()
                   
                   HStack{
                       Spacer()
                       Image("Logo")
                           .resizable()
                           .scaledToFit()
                           .frame(maxWidth: 200)
                           .padding(.trailing, 15)
                       Spacer()
                   }
               }
               
               ScrollView(.vertical) {
                   VStack(spacing: 0){
                       HeroView()
                           .frame(maxHeight: 270)
                       
                       ZStack{
                           Rectangle()
                               .foregroundColor(Color(hex: "#495E57"))
                           
                           HStack{
                               ZStack{
                                   Circle()
                                       .foregroundColor(Color(hex: "#EDEFEE"))
                                   Image(systemName: "magnifyingglass")
                                       .bold()
                                       .foregroundColor(Color(hex: "#333333"))
                               }
                               TextField("", text: $searchText)
                                   .foregroundColor(.white)
                                   .placeholder("Search Menu", when: searchText.isEmpty)
                               Spacer()
                           }
                           .padding([.bottom, .leading])
                       }
                       .frame(maxHeight: 50)
                   }
                   
                   FetchedObjects(predicate: buildPredicate()) { (dishes: [Dish]) in
                       VStack (spacing: 0){
                           ForEach(dishes) { dish in
                               Divider()
                               VStack{
                                   
                                   HStack{
                                       Text("\(dish.title ?? "No Data")")
                                           .font(.custom("Karla-Bold", size: 20))
                                       Spacer()
                                   }
                                   
                                   HStack(){
                                       
                                       Text("$"+"\(dish.price ?? "No Data")")
                                           .font(.custom("Karla-Regular", size: 20))
                                       
                                       Spacer()
                                       if let imageUrlString = dish.image, let imageUrl = URL(string: imageUrlString) {
                                           AsyncImage(url: imageUrl) { image in
                                               image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 100, height: 100)
                                        }
                                        .frame(maxWidth: 100, maxHeight: 100)
                                   }
                                   }
                               }
                               .padding()
                               Divider()
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
