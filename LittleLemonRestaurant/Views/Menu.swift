//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by Yasin Özdemir on 17.12.2024.
//

import SwiftUI
import CoreData
struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    init() {

    }
    var body: some View {

        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    heroView
                    menuBreakdownView

                    listView.frame(height: 750)
                }

                    .padding()
                    .toolbar(content: {
                    ToolbarItem(placement: .automatic) {
                        Image(.logo)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(.profileImagePlaceholder).resizable().frame(width: 50, height: 50).padding(.horizontal)
                    }
                })
            }

        }.onAppear {
            
            getMenuData()
        }
    }
 
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }

   
   
}

extension Menu {
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
   
    
    func getMenuData() {
        PersistenceController.shared.clear()
        URLSession.shared.dataTask(with: URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!) { data, response, error in
            if error != nil {
                return
            }

            guard let data = data else {
                return
            }

            do {
                let menuList = try JSONDecoder().decode(MenuList.self, from: data)

                guard let menuItems = menuList.menu else {
                    return
                }

                for menuItem in menuItems {
                    let dish = DishEntitie(context: viewContext)
                    dish.price = menuItem.price
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.desc = menuItem.description
                    dish.category = menuItem.category

                }
                try? viewContext.save()
            } catch {
                return
            }
            


        }.resume()
    }
}
extension Menu {
    private var heroView: some View {

        ZStack {
            Color.primaryGreen
            VStack(alignment: .leading) {
                Text("Little Lemon").font(.largeTitle).bold().foregroundStyle(.primaryYellow)

                Text("Chicago").font(.title).foregroundStyle(.white)

                HStack(spacing: 25) {
                    Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist").foregroundStyle(.white)
                    Image(.hero).resizable().frame(width: 130, height: 130).clipShape(RoundedRectangle(cornerRadius: 10))
                }

                HStack {
                    Image(systemName: "magnifyingglass.circle.fill").resizable().frame(width: 25, height: 25).foregroundStyle(.white)
                    TextField("Search menu", text: $searchText).padding()
                }.background {
                    RoundedRectangle(cornerRadius: 10).fill().opacity(0.1)
                }

            }
                .padding(.horizontal)
        }
    }

    private var menuBreakdownView: some View {
        return VStack {
            Text("ORDER FOR DELIVERY!").bold().font(.headline).foregroundStyle(.black).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            HStack(spacing: 40) {
                Button("Starters") {
                }.background {
                    RoundedRectangle(cornerRadius: 15).fill().opacity(0.1).frame(width: 80, height: 40)
                }
                    .tint(.primaryGreen)
                    .bold()
                    .font(.headline)

                Button("Mains") {
                }.background {
                    RoundedRectangle(cornerRadius: 15).fill().opacity(0.1).frame(width: 80, height: 40)
                }
                    .tint(.primaryGreen)
                    .bold()
                    .font(.headline)

                Button("Desserts") {
                }.background {
                    RoundedRectangle(cornerRadius: 15).fill().opacity(0.1).frame(width: 80, height: 40)
                }
                    .tint(.primaryGreen)
                    .bold()
                    .font(.headline)

                Button("Drinks") {
                }.background {
                    RoundedRectangle(cornerRadius: 15).fill().opacity(0.1).frame(width: 80, height: 40)
                }
                    .tint(.primaryGreen)
                    .bold()
                    .font(.headline)

            }.padding(.vertical)
            Divider()
        }
    }

    private var listView: some View {
        return FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [DishEntitie]) in
            List {
                ForEach(dishes) { dish in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(dish.title ?? "Unkown")").bold().font(.headline)
                            Spacer()
                            Text("\(dish.desc ?? "Unkown")").lineLimit(2)
                            Spacer()
                            Text("$\(dish.price ?? "Unkown")")

                        }.padding(.vertical)
                        /*AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image.image?.resizable().frame(width: 80, height: 80)
                        } */
                        Image(uiImage: (UIImage(named: dish.title ?? "Bruschetta") ?? UIImage(named : "Bruschetta"))!).resizable().frame(width: 80, height: 80)
                    }
                }
            }
                .listStyle(.plain)
                .scrollDisabled(true)
        }

    }

}
#Preview {
    Menu()
}
