//
//  HomeContentView.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/19/1399 AP.
//

import SwiftUI

struct HomeContentView: View {
    
    @ObservedObject  var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    newRepositories
                    mostStarRepositories
                    myRepositories
                    oldRepositories
                    Spacer()
                }
                Spacer()
            }.padding()
        }
        
    }
    
    @State private var showPopoverNewRepos: Bool = false
    var newRepositories: some View {
        VStack {
            HStack {
                Text("New Repositories")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("More") {
                    self.showPopoverNewRepos.toggle()
                }
                .font(.caption)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .popover(
                    isPresented: self.$showPopoverNewRepos,
                    arrowEdge: .bottom
                ) {
                    RepositoryListContentView(repoType: .New())
                }
            }
            
            if viewModel.newRepositories.isEmpty {
                EmptyContentView()
            } else {
                HorizontalList(viewModel.newRepositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }
        .animation(.easeInOut)
    }
    
    @State private var showPopoverMostStarRepos: Bool = false
    var mostStarRepositories: some View {
        VStack {
            HStack {
                Text("Most Star Repositories")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("More") {
                    self.showPopoverMostStarRepos.toggle()
                }
                .font(.caption)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .popover(
                    isPresented: self.$showPopoverMostStarRepos,
                    arrowEdge: .bottom
                ) {
                    RepositoryListContentView(repoType: .Star())
                }
            }
            .padding(.top, 20)
            
            if viewModel.mostStarRepositories.isEmpty {
                EmptyContentView()
            } else {
                HorizontalList(viewModel.mostStarRepositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }.animation(.easeInOut)
    }
    
    @State private var showPopoverMyRepos: Bool = false
    @State private var showingAlertMyRepos = false
    var myRepositories: some View {
        VStack {
            HStack {
                Text("My Repositories")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("More") {
                    if viewModel.myRepositories.isEmpty {
                        self.showingAlertMyRepos = true
                    } else {
                        self.showPopoverMyRepos.toggle()
                    }
                }
                .font(.caption)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .popover(
                    isPresented: self.$showPopoverMyRepos,
                    arrowEdge: .bottom
                ) {
                    RepositoryListContentView(repoType: .Me())
                }
                .alert(isPresented: $showingAlertMyRepos) {
                    Alert(title: Text("Warning !"), message: Text("There is not any Repository"), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.top, 20)
            
            if viewModel.myRepositories.isEmpty {
                EmptyContentView()
            } else {
                HorizontalList(viewModel.myRepositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }.animation(.easeInOut)
    }
    
    @State private var showPopoverOldRepos: Bool = false
    var oldRepositories: some View {
        VStack {
            HStack {
                Text("Old Repositories")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("More") {
                    self.showPopoverOldRepos.toggle()
                }
                .font(.caption)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .popover(
                    isPresented: self.$showPopoverOldRepos,
                    arrowEdge: .bottom
                ) {
                    RepositoryListContentView(repoType: .Old())
                }
            }
            .padding(.top, 20)
            
            if viewModel.oldRepositories.isEmpty {
                EmptyContentView()
            } else {
                HorizontalList(viewModel.oldRepositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }.animation(.easeInOut)
    }
}

struct RepositoryCardView: View {
    
    @State var repository: RepositoryResponse
    
    let width: CGFloat = 200
    let height: CGFloat = 125
    let circleSize: CGFloat = 12.0
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    starsView
                }
                
                HStack {
                    CircleImageView(imgUrl: repository.owner?.avatar_url ?? "", size: 32.0)
                    
                    Text(repository.name ?? "")
                        .font(.caption)
                        .bold()
                        .lineLimit(1)
                    Spacer()
                }
                
                Text(repository.description ?? "")
                    .font(.system(size: 10.0))
                    .fontWeight(.light)
                    .lineLimit(1)
                
                Text("Owner: \(repository.owner?.login ?? "")")
                    .font(.caption2)
                    .lineLimit(1)
                
                languageView
                
                Spacer()
            }
            .padding()
            .cardify(width: width, height: height)
        }
        .frame(width: width + 1, height: height + 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    var starsView: some View {
        HStack(spacing: 5) {
            Text(repository.stargazers_count.toString())
                .font(.system(size: 9.0))
                .opacity(0.75)
                .lineLimit(1)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.caption)
        }
    }
    
    var languageView: some View {
        HStack {
            if let language = parseJson(fileName: Constants.LANGUAGES_FILE_NAME,
                                        languageKey: repository.language ?? "") {
                Circle()
                    .foregroundColor(Color(hex: language.color!))
                    .frame(width: circleSize, height: circleSize)
                Text(repository.language ?? "")
                    .font(.system(size: 10))
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

struct EmptyContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "bag.fill")
                .foregroundColor(.gray)
                .opacity(0.75)
            Text("There is not any Repository !")
                .font(.caption2)
                .fontWeight(.light)
                .padding(.top, 1)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(viewModel: HomeViewModel())
    }
}
