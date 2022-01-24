//
//  ProfileScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 23/1/22.
//

import SwiftUI

struct ProfileScreen: View {
    @State var userName = "Usu Ario"
    var body: some View {
        ZStack {
            Color("bg_color")
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            VStack {
                Text("Perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(minWidth: 0,
                           idealWidth: 100,
                           maxWidth: .infinity,
                           alignment: .center
                    )
                    .padding()
                VStack {
                    Image("profilePicPlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118.0, height: 118.0, alignment: .center)
                        .clipShape(Circle())
                    Text(userName)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 0))
                
                Text("Ajustes")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(minWidth: 0,
                           idealWidth: 100,
                           maxWidth: .infinity,
                           alignment: .leading
                    )
                    .padding(.leading, 18)
                ProfileSettingsListView()
                Spacer()
            }
        }.onAppear(perform: {
            print("on appear profile")
        })
    }
}

struct ProfileSettingsListView: View {
    @State var screenState = ProfileSettingsState()
    
    var body: some View {
        VStack(spacing: 3){
            ProfileSettingsButton("Cuenta", action: {}) {
                Image(systemName: "chevron.right") .foregroundColor(.white)
            }
            ProfileSettingsButton("Notificaciones", action: {}) {
                Toggle("", isOn: $screenState.isToggleOn)
            }
            ProfileSettingsButton("Editar perfil", action: {
                screenState.isEditProfileViewActive = true
            }) {
                Image(systemName: "chevron.right") .foregroundColor(.white)
            }
            ProfileSettingsButton("Califica esta aplicación", action: {}) {
                Image(systemName: "chevron.right") .foregroundColor(.white)
            }
            NavigationLink(
                destination: EditProfileScreen(),
                isActive: $screenState.isEditProfileViewActive) {
                    EmptyView()
                }
        }
    }
}

struct ProfileSettingsState {
    var isToggleOn = false
    var isEditProfileViewActive = false
}

struct ProfileSettingsButton<Content: View>: View {
    let action: () -> Void
    let content: () -> Content
    let text: String
    
    init(_ text: String, action: @escaping () -> Void, leftView content: @escaping () -> Content) {
        self.action = action
        self.content = content
        self.text = text
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .foregroundColor(.white)
                Spacer()
                content()
                
            }.padding()
        }
        .background(Color("blue_gray"))
        .clipShape(RoundedRectangle(cornerRadius: 1.0))
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
