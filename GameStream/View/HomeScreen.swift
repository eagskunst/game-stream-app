//
//  HomeScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 4/1/22.
//

import SwiftUI
import AVKit
import Kingfisher

struct HomeScreen: View {
    
    @State var searchText = ""
    @State var isGameInfoEmpty = false
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    let urlVideos:[String] = ["https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256671638/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256720061/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256814567/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256705156/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256801252/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256757119/movie480.mp4"]
    
    @ObservedObject var searchViewModel = SearchGameViewModel()
    @State var isGameViewActive = false
    @State var searchedGame: GameViewObject? = nil
    
    let player: AVPlayer
    
    init() {
        player = AVPlayer()
    }
    
    var body: some View {
        ZStack {
            Color("bg_color").ignoresSafeArea()
            ScrollView {
                VStack {
                    Image("applogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.horizontal, 11)
                    HStack {
                        Button(action: watchGame) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(
                                    searchText.isEmpty ? .yellow : Color("dark_cyan")
                                )
                        }.alert(
                            isPresented: $isGameInfoEmpty) {
                            Alert(
                                title: Text("Error"),
                                message: Text("No se encontró el juego"),
                                dismissButton: .default(Text("Entendido")))
                        }
                        GameStreamAuthInput(
                            title: "",
                            placeholderText: "Buscar un video",
                            showPlaceholder: searchText.isEmpty,
                            inputTextColor: Color.white) {
                            TextField("", text: $searchText)
                        }
                    }.padding([.top, .leading, .bottom], 11)
                    .background(Color("blue_gray"))
                    .clipShape(Capsule())
                    
                    Text("Los más populares".uppercased())
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                        .frame(minWidth:0 ,maxWidth:.infinity, alignment: .leading)
                        .padding(.top)
                    
                    ZStack {
                        Button(action: {
                            url = urlVideos[0]
                            print("URL: \(url)")
                            isPlayerActive = true
                        }, label: {
                            VStack(spacing: 0){
                                Image("The Witcher 3")
                                    .resizable()
                                    .scaledToFit()
                                Text("The Witcher 3")
                                    .frame(minWidth:0 ,maxWidth:.infinity, alignment: .leading)
                                    .background(Color("blue_gray"))
                                
                            }
                        })
                        
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                    }.frame(minWidth:0 ,maxWidth:.infinity, alignment: .center)
                    .padding(.vertical)
                    
                    HomeCarousel("Categorías sugeridas para ti") {
                        HStack {
                            CategoryButton("FPS") {
                                
                            }
                            CategoryButton("RPG") {
                                
                            }
                            CategoryButton("OpenWorld") {
                                
                            }
                        }
                    }
                    
                    HomeCarousel("Recomendados para ti") {
                        HStack {
                            ImageButton("Abzu") {
                                url = urlVideos[1]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                            ImageButton("Crash Bandicoot") {
                                url = urlVideos[2]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                            ImageButton("DEATH STRANDING") {
                                url = urlVideos[3]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                        }
                    }
                    
                    NavigationLink(
                        destination: HomeVideoPlayer(urlString: url),
                        isActive: $isPlayerActive,
                        label: {
                            EmptyView()
                        }
                    )
                    if let game = searchedGame {
                        NavigationLink(
                            destination: GameScreen(gameVO: game),
                            isActive: $isGameViewActive,
                            label: {
                                EmptyView()
                            }
                        )
                    }
                }.padding(.horizontal, 18)
            }
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func watchGame() {
        isGameInfoEmpty = false
        print("searching \(searchText)")
        searchViewModel.search(
            game: searchText,
            onError: {
                isGameInfoEmpty = true
            }
        ) { games in
            guard let firstGame = games.first else { return }
            searchedGame = GameViewObject(game: firstGame)
            isGameViewActive = true
        }
    }
}

struct HomeCarousel<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(_ title: String, content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        Text(title.uppercased())
            .font(.title3)
            .foregroundColor(.white)
            .bold()
            .frame(
                minWidth:0,
                maxWidth: .infinity,
                alignment: .leading
            )
        
        ScrollView(.horizontal, showsIndicators: false) {
            content()
        }
    }
}

struct CategoryButton: View {
    let imageName: String
    let action: () -> Void
    
    init(_ imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("blue_gray"))
                    .frame(width: 160, height: 90)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 42)
            }
        }
    }
}

struct ImageButton: View {
    let imageName: String
    var imgUrl: URL?
    let action: () -> Void
    
    init(_ imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
        self.imgUrl = nil
    }
    
    init(imgUrl: String, action: @escaping () -> Void) {
        self.imgUrl = URL(string: imgUrl)
        self.action = action
        self.imageName = ""
    }
    
    var body: some View {
        Button(action: action) {
            if let actualUrl = imgUrl {
                KFImage(actualUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 135)
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 135)
            }
        }
    }
    
}

struct HomeVideoPlayer: View {
    let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
    
    var body: some View {
        if let videoUrl = url {
            let player = AVPlayer(url: videoUrl)
            VideoPlayer(player: player)
                .frame(width: 400, height: 300)
                .onDisappear(perform: {
                    player.pause()
                })
        } else {
            EmptyView()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
