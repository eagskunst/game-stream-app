//
//  SearchGameViewModel.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 11/1/22.
//

import Foundation

class SearchGameViewModel: ObservableObject {
    
    func search(
        game gameName: String,
        onError: @escaping () -> Void,
        whenFound: @escaping ([Game]) -> Void
    ) {
        let gameNameSpaces = gameName
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games/search?contains=\(gameNameSpaces)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let jsonData = data {
                    print("json size: \(jsonData)")
                    let decocedData = try JSONDecoder().decode(SearchedGames.self, from: jsonData)
                    DispatchQueue.main.async {
                        if decocedData.results.isEmpty {
                            onError()
                        } else {
                            whenFound(decocedData.results)
                        }
                    }
                }
            } catch {
                print("Error: \(error)")
                onError()
            }
        }.resume() //executes the http petition
    }
}

