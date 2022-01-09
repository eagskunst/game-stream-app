//
//  Home.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 2/1/22.
//

import SwiftUI

struct MainScreen: View {
    
    @State var selectedTab = 0
    
    init() {
        let appearance = UITabBar.appearance()
        appearance.barTintColor = UIColor(Color("tabbar_color"))
        appearance.unselectedItemTintColor = .gray
        appearance.isTranslucent = true
        print("initiating home views")
    }
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(0)
            
            GamesListScreen()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Juegos")
                }.tag(1)
            
            Text("Favoritos")
                .font(
                    .system(size: 30, weight: .bold, design: .rounded)
                )
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(2)
            
            Text("Perfil")
                .font(
                    .system(size: 30, weight: .bold, design: .rounded)
                )
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }.tag(3)
        }.accentColor(.white)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
