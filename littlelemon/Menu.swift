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
    @State var categories: Set<String> = ["Drinks"]
    @State var selectedCategories: Set<String> = []
    @State var tappedCategories: Set<String> = []
       
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
                   
                   VStack(alignment: .leading, spacing: 0){
                       Text("ORDER FOR DELIVERY!")
                           .font(.custom("Karla-ExtraBold", size: 20))
                           .padding()
                       HStack {
                                   ForEach(Array(categories), id: \.self) { category in
                                       CapsuleView(category: category, isTapped: tappedCategories.contains(category))
                                           .onTapGesture {
                                               if tappedCategories.contains(category) {
                                                   tappedCategories.remove(category)
                                                   selectedCategories.remove(category)
                                               } else {
                                                   tappedCategories.insert(category)
                                                   selectedCategories.insert(category)
                                               }
                                           }
                                    }
                                }
                       .padding([.leading, .trailing])
                       .padding([.top, .bottom], 5)

                   }
                   FetchedObjects(predicate: buildPredicate()) { (dishes: [Dish]) in
                       VStack (spacing: 0){
                           ForEach(dishes) { dish in
                               Divider()
                               VStack(spacing: 0){
                                   
                                   HStack{
                                       Text("\(dish.title ?? "No Data")")
                                           .font(.custom("Karla-Bold", size: 20))
                                       Spacer()
                                   }
                                   
                                   HStack(){
                                       
                                       VStack (alignment: .leading){
                                           Text("\(dish.discriptor ?? "No Data")")
                                               .font(.custom("Karla-Regular", size: 18))
                                               .foregroundColor(Color(hex: "#333333"))
                                               .frame(height: 60)
                                           Spacer()
                                           Text("$"+"\(dish.price ?? "No Data")")
                                               .font(.custom("Karla-Regular", size: 20))
                                               .foregroundColor(Color(hex: "#333333"))
                                       }
                                       
                                       Spacer()
                                       if let imageUrlString = dish.image, let imageUrl = URL(string: imageUrlString) {
                                           AsyncImage(url: imageUrl) { image in
                                               image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        }
                                        .frame(maxWidth: 80, maxHeight: 80)
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
                        dish.discriptor = menuItem.description
                        categories.insert(dish.category ?? "")
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
        var predicates = [NSPredicate]()
        
        if searchText.isEmpty {
            predicates.append(NSPredicate(value: true))
        } else {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if selectedCategories.isEmpty {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }else{
            predicates.append(NSPredicate(format: "category IN %@", selectedCategories))
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
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
