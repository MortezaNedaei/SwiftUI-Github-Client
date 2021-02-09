//
//  MainContentView.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/19/1399 AP.
//

import SwiftUI

struct MainContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            NewsView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("News")
                }.tag(2)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(3)
        }
        .accentColor(.black)
        
        
    }
}

struct HomeView: View {
    var body: some View {
        HomeContentView(viewModel: HomeViewModel())
    }
}

struct SearchView: View {
    var body: some View {
        Text("Search will be added Soon !")
    }
}

struct NewsView: View {
    var body: some View {
        Text("News will be added Soon !")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile will be added Soon !")
    }
}


struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
