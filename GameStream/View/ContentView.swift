//
//  ContentView.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 28/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
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
                }.padding(.horizontal, 30)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Image("pantalla1")
            .resizable()
        Image("pantalla2")
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
        }
        
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
    @State var isAuthenticated = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                GameStreamAuthInput(
                    title: "Correo electrónico",
                    placeholderText: "ejemplo@gmail.com",
                    showPlaceholder: email.isEmpty,
                    inputTextColor: Color.white
                ) {
                    TextField(
                        "",
                        text: $email
                    )
                }
                GameStreamAuthInput(
                    title: "Contraseña",
                    placeholderText: "********",
                    showPlaceholder: password.isEmpty,
                    inputTextColor: Color.white
                ) {
                    SecureField(
                        "",
                        text: $password
                    )
                }
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(Color("dark_cyan"))
                    .padding(.bottom)
                Button(action: logIn, label: {
                    Text("Iniciar sesión".uppercased())
                        .borderBackgroundlessStyle()
                }).padding(.bottom, 40)
                
                
                Text("Inicia sesión con redes sociales")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack(alignment: .center) {
                    GrayButton("Facebook", 150) {
                        print("click facebook")
                    }
                    Spacer()
                    GrayButton("Twitter", 150) {
                        print("click facebook")
                    }
                }.padding(.top)
            }.frame(width: .infinity)
            NavigationLink(
                destination: MainScreen(),
                isActive: $isAuthenticated,
                label: {
                    EmptyView()
                }
            )
        }
    }
    
    func logIn() {
        print("iniciando sesion")
        isAuthenticated = true
    }
}

struct SocialMediaLoginButton : View {
    
    let text: String
    let action: () -> Void
    
    init(
        text: String,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: self.action, label: {
            Text(text)
        })
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmedPassword = ""
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Text("Elige una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Puedes cambiar o elegilarla mas adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: takePicture) {
                    ZStack {
                        Image("profilePicPlaceholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                    }
                }.padding(.bottom, 20)
                VStack(alignment: .leading) {
                    
                    GameStreamAuthInput(
                        title: "Correo electrónico",
                        placeholderText: "ejemplo@gmail.com",
                        showPlaceholder: email.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        TextField(
                            "",
                            text: $email
                        )
                    }
                    GameStreamAuthInput(
                        title: "Contraseña",
                        placeholderText: "********",
                        showPlaceholder: password.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        SecureField(
                            "",
                            text: $password
                        )
                    }
                    GameStreamAuthInput(
                        title: "Confirmar contraseña",
                        placeholderText: "********",
                        showPlaceholder: confirmedPassword.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        SecureField(
                            "",
                            text: $confirmedPassword
                        )
                    }

                    Button(action: signUp, label: {
                        Text("Regístrate".uppercased())
                            .borderBackgroundlessStyle()
                    }).padding(.bottom, 40)
                    
                    
                    Text("Regístrate con redes sociales")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    HStack(alignment: .center) {
                        GrayButton("Facebook", 150) {
                            print("click facebook")
                        }
                        Spacer()
                        GrayButton("Twitter", 150) {
                            print("click facebook")
                        }
                    }.padding(.top)
                }.frame(width: .infinity)
            }
        }
    }
    
    func takePicture() {
        print("📷")
    }

    func signUp() {
        print("registrarse")
    }

}
