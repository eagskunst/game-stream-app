//
//  UserDataSaver.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 24/1/22.
//

import Foundation

class UserDataSaver : ObservableObject {
    
    static let USER_DATA_KEY = "user_data"
    @Published var userName = ""
    @Published var email = ""
    
    func saveData(
        email: String,
        password: String,
        username: String
    ) -> Bool {
        print("data: \(email); \(password); \(username)")
        
        UserDefaults.standard.set([email, password, username], forKey: UserDataSaver.USER_DATA_KEY)
        return true
    }
    
    func getData() -> [String] {
        let userData = UserDefaults.standard.stringArray(forKey: UserDataSaver.USER_DATA_KEY) ?? []
        print("data in for each", terminator: ": ")
        userData.forEach { str in
            print(str, terminator: " ")
        }
        print("")
        userName = userData[2, default: "Your name"]
        email = userData[0, default: ""]
        return userData
    }
    
    func validate(email: String, password: String) -> Bool {
        guard let userData = UserDefaults.standard.stringArray(forKey: UserDataSaver.USER_DATA_KEY) else {
            print("no hay datos guarados")
            return false
        }
        let savedEmail = userData[0]
        let savedPassword = userData[1]
        
        return savedEmail == email && savedPassword == password
    }
}

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }

        return self[index]
    }
}
