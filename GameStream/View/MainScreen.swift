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
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(Color("tabbar_color"))
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
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
            
            FavoritesScreen()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(2)
            
            ProfileScreen()
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
