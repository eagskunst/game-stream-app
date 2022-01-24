//
//  ViewModel.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 8/1/22.
//

import Foundation

class GamesViewModel: ObservableObject {
    @Published var gamesInfo = [Game]()
    
    init() {
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let jsonData = data {
                    print("json size: \(jsonData)")
                    let decocedData = try JSONDecoder().decode([Game].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.gamesInfo.append(contentsOf: decocedData)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume() //executes the http petition
    }
}
