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
    
    @State var state = LogInState()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                GameStreamAuthInput(
                    title: "Correo electrónico",
                    placeholderText: "ejemplo@gmail.com",
                    showPlaceholder: state.email.isEmpty,
                    inputTextColor: Color.white
                ) {
                    TextField(
                        "",
                        text: $state.email
                    )
                }
                GameStreamAuthInput(
                    title: "Contraseña",
                    placeholderText: "********",
                    showPlaceholder: state.password.isEmpty,
                    inputTextColor: Color.white
                ) {
                    SecureField(
                        "",
                        text: $state.password
                    )
                }
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(Color("dark_cyan"))
                    .padding(.bottom)
                Button(action: logIn) {
                    Text("Iniciar sesión".uppercased())
                        .borderBackgroundlessStyle()
                }.padding(.bottom, 40)
                    .alert(isPresented: $state.showUserNotFoundAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Usuario no registrado"),
                            dismissButton: .default(
                                Text("Entendido")
                            )
                        )
                    }
                
                
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
                isActive: $state.isAuthenticated,
                label: {
                    EmptyView()
                }
            )
        }
    }
    
    func logIn() {
        let userDataSaver = UserDataSaver()
        state.isAuthenticated = userDataSaver.validate(
            email: state.email,
            password: state.password
        )
        print("iniciando sesion")
    }
}

struct LogInState {
    var email = ""
    var password = ""
    var isAuthenticated = false {
        willSet {
            showUserNotFoundAlert = !newValue
        }
    }
    var showUserNotFoundAlert = false
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
    
    @State var state = SignUpState()
    let formValidator = SignUpFormValidator()
    
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
                        showPlaceholder: state.email.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        TextField(
                            "",
                            text: $state.email
                        )
                    }
                    GameStreamAuthInput(
                        title: "Contraseña",
                        placeholderText: "********",
                        showPlaceholder: state.password.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        SecureField(
                            "",
                            text: $state.password
                        )
                    }
                    GameStreamAuthInput(
                        title: "Confirmar contraseña",
                        placeholderText: "********",
                        showPlaceholder: state.confirmedPassword.isEmpty,
                        inputTextColor: Color.white
                    ) {
                        SecureField(
                            "",
                            text: $state.confirmedPassword
                        )
                    }
                    
                    Button(action: signUp, label: {
                        Text("Regístrate".uppercased())
                            .borderBackgroundlessStyle()
                    }).padding(.bottom, 40)
                        .alert(isPresented: $state.isInvalidForm) {
                            Alert(
                                title: Text("Error"),
                                message: Text(state.isValidFormTuple.1 ?? ""),
                                dismissButton: .default(
                                    Text("Entendido")
                                )
                            )
                        }
                    
                    
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
                
                NavigationLink(
                    destination: MainScreen(),
                    isActive: $state.isValidForm,
                    label: {
                        EmptyView()
                    }
                )
            }
        }
    }
    
    func takePicture() {
        print("📷")
    }
    
    func signUp() {
        print("registrando usuario")
        state.isValidFormTuple = formValidator.validate(
            email: state.email,
            password: state.password,
            confirmedPassword: state.confirmedPassword
        )
        print(state.isValidFormTuple)
        print(state.isInvalidForm)
    }
    
}

struct SignUpState {
    var email = ""
    var password = ""
    var confirmedPassword = ""
    var isValidFormTuple: (Bool, String?) = (false, nil) {
        willSet {
            isValidForm = newValue.0
            isInvalidForm = newValue.1 != nil
        }
    }
    var isValidForm: Bool = false
    var isInvalidForm: Bool = false
}
