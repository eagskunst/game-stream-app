//
//  UserDataSaver.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 24/1/22.
//

import Foundation

class UserDataSaver {
    
    static let USER_DATA_KEY = "user_data"
    
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
        let userData = UserDefaults.standard.stringArray(forKey: UserDataSaver.USER_DATA_KEY)
        userData?.forEach { str in
            print("data: \(str)", terminator: " ")
        }
        print("")
        return userData ?? []
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
