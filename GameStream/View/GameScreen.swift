//
//  GameScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 9/1/22.
//

import SwiftUI
import AVKit

struct GameScreen: View {
    
    let gameVO: GameViewObject
    
    init(gameVO: GameViewObject) {
        self.gameVO = gameVO
    }
    
    var body: some View {
        ZStack {
            Color("bg_color")
                .ignoresSafeArea()
            VStack {
                GameVideo(url: gameVO.url)
                    .frame(height: 300)
                
                ScrollView {
                    GameInfo(gameVO: gameVO)
                        .padding(.bottom)
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

struct GameVideo: View {
    
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        let player = AVPlayer(url: URL(string: url)!)
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onDisappear(perform: {
                player.pause()
            })
    }
}

struct GameInfo: View {
    let gameVO: GameViewObject
    var comments: [CommentViewObject] = []
    
    init(gameVO: GameViewObject) {
        self.gameVO = gameVO
        comments.append(
            CommentViewObject(
                userName: "Tony Stark",
                days: 7,
                description: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.",
                avatarUrl: "https://i.pravatar.cc/300"
            )
        )
        comments.append(
            CommentViewObject(
                userName: "Natasha Romanoff",
                days: 12,
                description: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.",
                avatarUrl: "https://i.pravatar.cc/300"
            )
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(gameVO.title)
                .foregroundColor(.white)
                .font(.largeTitle)
            HStack {
                Text(gameVO.getBasicInfo())
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top)
            }
            Text(gameVO.description)
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5)
            HStack {
                ForEach(gameVO.tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }.padding(.top, 4)
            
            GameGallery(imgsUrls: gameVO.imgUrls)
                .padding(.top, 5)
            
            Text("Comentarios".uppercased())
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(
                    minWidth:0,
                    maxWidth: .infinity,
                    alignment: .leading
                )
            LazyVStack {
                ForEach(comments, id: \.self) { comment in
                    CommentView(comment)
                }
            }
            HomeCarousel("Juegos similares") {
                HStack {
                    ImageButton("Abzu") {}
                    ImageButton("Crash Bandicoot") {}
                    ImageButton("DEATH STRANDING") {}
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .trailing])
    }
    
}

struct GameGallery: View {
    let imgUrls: [String]
    
    let gridForm = [
        GridItem(.flexible())
    ]
    
    init(imgsUrls: [String]) {
        self.imgUrls = imgsUrls
    }
    
    var body: some View {
        HomeCarousel("Galería"){
            LazyHStack {
                ForEach(imgUrls, id: \.self) { url in
                    ImageButton(imgUrl: url) {}
                }
            }
        }
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        let gameVO = GameViewObject(
            url: "ejemplo",
            title: "Sonic The Hedgehog",
            studio: "SEGA",
            calification: "E+",
            pubYear: "1991",
            description: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente",
            tags: ["platforms", "pets"],
            imgUrls: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"]
        )
        GameScreen(gameVO: gameVO)
    }
}
