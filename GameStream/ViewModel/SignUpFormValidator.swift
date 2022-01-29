//
//  SignUpFormValidator.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 24/1/22.
//

import Foundation

//simple form validator
class SignUpFormValidator {
    private let userDataSaver = UserDataSaver() //should be injected
    
    func validate(email: String, password: String, confirmedPassword: String) -> (Bool, String?) {
        if email.isEmpty {
            return (false, "El email esta vacío.")
        }
        else if password.isEmpty {
            return (false, "La contraseña esta vacía.")
        }
        else if confirmedPassword.isEmpty {
            return (false, "La contraseña repetida esta vacía.")
        }
        else if password != confirmedPassword {
            return (false, "Las contraseñas no coinciden.")
        }
        let result = userDataSaver.saveData(email: email, password: password, username: "Lorem")
        return (result, nil)
    }
}
