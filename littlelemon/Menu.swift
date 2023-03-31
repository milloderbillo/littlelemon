//
//  Menu.swift
//  littlelemon
//
//  Created by Milo Edelbi on 26.03.23.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder Placeholder")
            List{
                
            }
        }
        .onAppear{
            getMenuData()
        }
    }
    
    func getMenuData() {
        let serverURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: serverURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                let fullMenu = try? JSONDecoder().decode(JSONMenu.self, from: data)
            }
        }
        task.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
