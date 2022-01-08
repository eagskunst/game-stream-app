//
//  HomeScreen.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 4/1/22.
//

import SwiftUI
import AVKit

struct HomeScreen: View {
    
    @State var searchText = ""
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    let urlVideos:[String] = ["https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256671638/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256720061/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256814567/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256705156/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256801252/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256757119/movie480.mp4"]
    
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
                        Button(action: search) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(
                                    searchText.isEmpty ? .yellow : Color("dark_cyan")
                                )
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
                            RecomendedButton("Abzu") {
                                url = urlVideos[1]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                            RecomendedButton("Crash Bandicoot") {
                                url = urlVideos[2]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                            RecomendedButton("DEATH STRANDING") {
                                url = urlVideos[3]
                                print("URL: \(url)")
                                isPlayerActive = true
                            }
                        }
                    }
                    
                    NavigationLink(
                        destination:
                            VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                            .frame(width: 400, height: 300),
                        isActive: $isPlayerActive,
                        label: {
                            EmptyView()
                        }
                    )
                }.padding(.horizontal, 18)
            }
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func search() {
        print("searching \(searchText)")
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

struct RecomendedButton: View {
    let imageName: String
    let action: () -> Void
    
    init(_ imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 135)
        }
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
