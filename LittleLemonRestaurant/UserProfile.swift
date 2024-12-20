//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by Yasin Özdemir on 17.12.2024.
//

import SwiftUI

struct UserProfile: View {
    private let firstName = UserDefaults.standard.string(forKey: kFirstName)
    private let lastName = UserDefaults.standard.string(forKey: kLastName)
    private let email = UserDefaults.standard.string(forKey: kEmail)
    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            VStack(spacing :20) {
                Text("Personal Information").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)

                avatarView

                userInfoText(title: "First name", text: firstName ?? "Unknown")
                userInfoText(title: "Last name", text: lastName ?? "Unkown")
                userInfoText(title: "Email", text: email ?? "Unkown")

                Button {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    presentation.wrappedValue.dismiss()
                } label: {
                    Text("Log Out")
                }.background {
                    RoundedRectangle(cornerRadius: 10).fill().frame(width: 350, height: 50).foregroundStyle(.primaryYellow)
                }
                .tint(.primary).bold()
                    .padding(.vertical)
                
                HStack(spacing : 20) {
                
                    Button("Discard changes") {

                    }.buttonStyle(.borderedProminent).foregroundStyle(.primaryGreen).tint(.white).border(Color.primaryGreen, width: 1)
                    
                    Button("Save changes") {

                    }.buttonStyle(.borderedProminent).foregroundStyle(.white).tint(.primaryGreen)

                   
                }
                Spacer()
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.logo)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(.profileImagePlaceholder).resizable().frame(width: 50, height: 50).padding(.horizontal)
                }


            }

        }
    }

}

extension UserProfile {
    private var avatarView: some View {
        return VStack(alignment: .leading) {
            Text("Avatar")
                .font(.caption).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()

            HStack(spacing : 20) {
                Image(.profileImagePlaceholder).resizable().frame(width: 70, height: 70)

                Button("Change") {

                }.buttonStyle(.borderedProminent).foregroundStyle(.white).tint(.primaryGreen)

                Button("Remove") {

                }.buttonStyle(.borderedProminent).foregroundStyle(.primaryGreen).tint(.white).border(Color.primaryGreen, width: 1)
            }
        }.padding(.horizontal)
    }

    private func userInfoText(title: String, text: String) -> some View {
        return VStack {
            Text(title)
                .font(.caption).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            
            Text(text).padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 10).fill().opacity(0).border(Color.secondary, width: 0.5)
                }
        }.padding(.horizontal)
      
            
    }
}

#Preview {
    UserProfile()
}
