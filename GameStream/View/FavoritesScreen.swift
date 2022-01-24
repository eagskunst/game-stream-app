//
//  FavoritesScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 23/1/22.
//

import SwiftUI
import AVKit

struct FavoritesScreen: View {
    
    @ObservedObject var gamesViewModel = GamesViewModel()
    
    var body: some View {
        ZStack {
            Color("bg_color")
                .ignoresSafeArea()
            VStack {
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView {
                    ForEach(gamesViewModel.gamesInfo, id: \.self) { game in
                        VStack(spacing: 0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!))
                                .frame(height: 300)
                            Text(game.title)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color("blue_gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        
                    }
                }.padding(.bottom, 8)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
    }
}
