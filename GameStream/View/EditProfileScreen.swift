//
//  EditProfileScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 23/1/22.
//

import SwiftUI

struct EditProfileScreen: View {
    var body: some View {
        ZStack {
            Color("bg_color")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Editar perfil")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical)
                    Button(action: {}, label: {
                        ZStack {
                            Image("profilePicPlaceholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                            .clipShape(Circle())
                            Color(hex: 0x000000, alpha: 0.25)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                            .clipShape(Circle())
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 32, height: 28, alignment: .center)
                                .foregroundColor(.white)
                            
                        }
                    }).padding(.bottom, 20)
                    EditProfileInputs()
                    Spacer()
                }.padding(.bottom, 18.0)
            }
        }
    }
}

struct EditProfileInputs: View {
    @State var state = EditProfileState()
    
    var body: some View {
        VStack(alignment: .leading) {
            GameStreamAuthInput(
                title: "Correo electrónico",
                placeholderText: "ejemplo@gmail.com",
                showPlaceholder: state.email.isEmpty,
                inputTextColor: .white) {
                TextField("", text: $state.email)
            }
            GameStreamAuthInput(
                title: "Contraseña",
                placeholderText: "Introduce tu nueva contraseña",
                showPlaceholder: state.password.isEmpty,
                inputTextColor: .white) {
                SecureField("", text: $state.password)
            }
            GameStreamAuthInput(
                title: "Nombre",
                placeholderText: "Introduce tu nombre de usuario",
                showPlaceholder: state.name.isEmpty,
                inputTextColor: .white) {
                SecureField("", text: $state.name)
            }
            Button(action: updateData, label: {
                Text("Actualizar datos".uppercased())
                    .borderBackgroundlessStyle()
            }).padding(.bottom)
        }.padding(.horizontal, 42)
    }
    
    func updateData() {
        let dataUpdater = UserDataSaver()
        let result = dataUpdater.saveData(
            email: state.email,
            password: state.password,
            username: state.name
        )
        print("User data saved? \(result)")
    }
}

struct EditProfileState {
    var email = ""
    var password = ""
    var name = ""
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen()
    }
}
