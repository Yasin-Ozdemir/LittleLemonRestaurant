//
//  Home.swift
//  LittleLemonRestaurant
//
//  Created by Yasin Özdemir on 17.12.2024.
//

import SwiftUI
import CoreData
struct Home: View {
    let persistence = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Text("Menu")
                    Image(systemName: "list.dash")
                }
            
            UserProfile()
                .tabItem {
                    Text("Profile")
                    Image(systemName: "square.and.pencil")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
