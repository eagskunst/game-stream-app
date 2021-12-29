//
//  ContentView.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 28/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color(red: 19/255, green: 30/255, blue: 52/255, opacity: 1.0)
                .ignoresSafeArea()
            
            VStack {
                Image("applogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom, 40)
                AuthView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Image("pantalla1")
            .resizable()
        ContentView()
    }
}

struct AuthView: View {
    
    @State var showLogInScreen = true
    
    var body: some View {
        HStack {
            Button("Inicia sesión".uppercased()) {
                showLogInScreen = true
            }
            .foregroundColor( showLogInScreen ? .white : .gray)
            Spacer()
            Button("Regístrate".uppercased()) {
                showLogInScreen = false
            }
            .foregroundColor( !showLogInScreen ? .white : .gray)
        }.padding(.horizontal, 30)
        
        Spacer(minLength: 42)
        
        if showLogInScreen {
            LogInView()
        } else {
            SignUpView()
        }
    }
}

struct LogInView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                GameStreamAuthInput(
                    title: "Correo electrónico",
                    placeholderText: "ejemplo@gmail.com",
                    showPlaceholder: email.isEmpty
                ) {
                    TextField(
                        "",
                        text: $email
                    )
                }
                GameStreamAuthInput(
                    title: "Contraseña",
                    placeholderText: "********",
                    showPlaceholder: password.isEmpty
                ) {
                    SecureField(
                        "",
                        text: $password
                    )
                }
            }.padding(.horizontal, 77)
        }
    }
}

struct SignUpView: View {
    var body: some View {
        Text("registrarse")
    }
}
