//
//  GameScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 7/1/22.
//

import SwiftUI
import Kingfisher

struct GameViewObject {
    let url: String
    let title: String
    let studio: String
    let calification: String
    let pubYear: String
    let description: String
    let tags: [String]
    let imgUrls: [String]
    
    init(game: Game) {
        url = game.videosUrls.mobile
        title = game.title
        studio = game.studio
        calification = game.contentRaiting
        pubYear = game.publicationYear
        description = game.description
        tags = game.tags
        imgUrls = game.galleryImages
    }
    
    init(url: String,
         title: String,
         studio: String,
         calification: String,
         pubYear: String,
         description: String,
         tags: [String],
         imgUrls: [String]) {
        let game = Game(
            title: title,
            studio: studio,
            contentRaiting: calification,
            publicationYear: pubYear,
            description: description,
            platforms: [],
            tags: tags,
            videosUrls: VideoUrl(mobile: url, tablet: ""),
            galleryImages: imgUrls
        )
        self.init(game: game)
    }
    
    func getBasicInfo(separator: String = "-") -> String {
        return "\(studio) \(separator) \(calification) \(separator) \(pubYear)"
    }
}

struct GamesListScreen: View {
    @ObservedObject var gamesViewModel = GamesViewModel()
    @State var isGameViewActive = false
    @State var gameVO: GameViewObject? = nil
    
    let gridForm = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color("bg_color").ignoresSafeArea()
            VStack {
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                ScrollView {
                    LazyVGrid(
                        columns: gridForm,
                        spacing: 8) {
                        ForEach(gamesViewModel.gamesInfo, id: \.self){
                            game in
                            Button(action: {
                                gameVO = GameViewObject(game: game)
                                isGameViewActive = true
                                print("tapped game \(gameVO!.title)")
                            }) {
                                KFImage(URL(string: game.galleryImages.first ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle.init(cornerRadius: 4))
                                    .padding(.bottom, 12)
                            }
                        }
                    }
                }
            }.padding(.horizontal, 6)
            
            if let game = gameVO {
                NavigationLink(
                    destination: GameScreen(gameVO: game),
                    isActive: $isGameViewActive,
                    label: {
                        EmptyView()
                    })
            }
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GamesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        GamesListScreen()
    }
}
