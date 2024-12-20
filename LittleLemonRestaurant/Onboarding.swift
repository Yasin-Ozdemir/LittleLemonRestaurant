//
//  Onboarding.swift
//  LittleLemonRestaurant
//
//  Created by Yasin Özdemir on 17.12.2024.
//

import SwiftUI

public let kFirstName = "firstNameKey"
public let kLastName = "lastNameKey"
public let kEmail = "emailKey"
public let kIsLoggedIn = "kIsLoggedIn"
struct Onboarding: View {
    
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var email : String = ""
    @State var isLoggedIn : Bool = false
    var body: some View {
        
        ZStack {
            Color.clear
            NavigationView {
                VStack(alignment: .center , spacing: 15) {
                    NavigationLink(destination: Home() , isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    heroView.frame(height: 250)
                    TextField("First Name", text: $firstName)
                        .lineLimit(1)
                        .frame(width: 300)
                        .padding(.vertical , 10).padding(.leading, 8)
                        .background() {
                            RoundedRectangle(cornerRadius: 10)
                                .opacity(0.15)
                        }
                    
                    
                    TextField("Last Name", text: $lastName).lineLimit(1)
                        .frame(width: 300)
                        .padding(.vertical , 10).padding(.leading, 8)
                        .background() {
                            RoundedRectangle(cornerRadius: 10)
                                .opacity(0.15)
                        }
                    TextField("Email", text: $email).lineLimit(1)
                        .frame(width: 300)
                        .padding(.vertical , 10).padding(.leading, 8)
                        .background() {
                            RoundedRectangle(cornerRadius: 10)
                                .opacity(0.15)
                        }
                    
                    Button("Register")
                    {
                        registerUser()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 15).foregroundStyle(.primaryGreen).frame(width: 150, height: 50)
                    }
                    .tint(.primaryYellow)
                    .padding(.top)
                    
                    Spacer(minLength: 250)
                    
                }
                .padding()
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        Image(.logo)
                    }
                    
                })
            }.onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
        
    }
    
    func registerUser(){
        guard !firstName.isEmpty || !lastName.isEmpty || !email.isEmpty else {
            print("Please check your inputs")
            return
        }
        
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        isLoggedIn = true
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
    }
}
extension Onboarding {
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
            }
            .padding(.horizontal)
        }
    }
}
#Preview {
    Onboarding()
}
