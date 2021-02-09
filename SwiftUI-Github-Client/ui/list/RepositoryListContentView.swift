//
//  RepositoryListContentView.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import SwiftUI

enum RepositoryType {
    case New(title: String = "Last Updated Repositories")
    case Star(title: String = "Most Star Repositories")
    case Me(title: String = "My Repositories")
    case Old(title: String = "Old Repositories")
}

struct RepositoryListContentView: View {
    
    var repoType: RepositoryType
    
    /// to return defferent View types from switch, you can use [AnyView] instead of [some View]
    func viewFor(repositoryType type: RepositoryType) -> AnyView {
        switch (type) {
        case .New:
            return AnyView(NewRepositoriesContentView(viewModel: NewRepositoriesViewModel()))
        case .Star:
            return AnyView(MostStarRepositoriesContentView(viewModel: MostStarRepositoriesViewModel()))
        case .Me:
            return AnyView(MyRepositoriesContentView(viewModel: MyRepositoriesViewModel()))
        case .Old:
            return AnyView(OldRepositoriesContentView(viewModel: OldRepositoriesViewModel()))
        }
    }
    
    var body: some View {
        Group {
            return viewFor(repositoryType: repoType)
        }
    }
    
}

struct NewRepositoriesContentView: View {
    
    @ObservedObject  var viewModel: NewRepositoriesViewModel
    
    
    var body: some View {
        NavigationView {
            List(viewModel.repositories) {repository in
                RepositoryRow(repository: repository)
            }
            .navigationBarTitle("New Repositories")
        }
    }
}

struct MostStarRepositoriesContentView: View {
    
    @ObservedObject  var viewModel: MostStarRepositoriesViewModel
    
    
    var body: some View {
        NavigationView {
            List(viewModel.repositories) {repository in
                RepositoryRow(repository: repository)
            }
            .navigationBarTitle("Most Star Repositories")
        }
    }
}

struct MyRepositoriesContentView: View {
    
    @ObservedObject  var viewModel: MyRepositoriesViewModel
    
    
    var body: some View {
        NavigationView {
            List(viewModel.repositories) {repository in
                RepositoryRow(repository: repository)
            }
            .navigationBarTitle("My Repositories")
        }
    }
}

struct OldRepositoriesContentView: View {
    
    @ObservedObject  var viewModel: OldRepositoriesViewModel
    
    
    var body: some View {
        NavigationView {
            List(viewModel.repositories) {repository in
                RepositoryRow(repository: repository)
            }
            .navigationBarTitle("Old Repositories")
        }
    }
}

struct RepositoryRow: View {
    
    @State var repository: RepositoryResponse
    
    var circleSize: CGFloat = 12.0
    
    var body: some View {
        HStack {
            CircleImageView(imgUrl: repository.owner?.avatar_url)
            VStack(alignment: .leading) {
                Text(repository.full_name ?? "")
                    .font(Font.callout).bold()
                    .lineLimit(1)
                Text(repository.description ?? "")
                    .font(.caption2)
                    .lineLimit(2)
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    starsView
                    forksView
                    watchersView
                    languageView
                })
            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    var starsView: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.caption)
            Text(repository.stargazers_count.toString())
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var forksView: some View {
        HStack(spacing: 0) {
            Image(systemName: "tuningfork")
                //.resizable()
                .rotationEffect(Angle(degrees: -45.0))
                .foregroundColor(.gray)
                //.scaledToFill()
                //.frame(width: 10.0, height:5)
                .scaleEffect(CGSize(width: 0.75, height: 0.5))
            Text(repository.forks.toString())
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var watchersView: some View {
        HStack(spacing: 0) {
            Image(systemName: "eye.fill")
                .foregroundColor(.gray)
                .scaleEffect(0.6)
            Text(repository.watchers.toString())
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var languageView: some View {
        Group {
            Spacer()
            if let language = parseJson(fileName: Constants.LANGUAGES_FILE_NAME,
                                        languageKey: repository.language ?? "") {
                Text(repository.language ?? "")
                    .font(.caption2)
                    .lineLimit(1)
                Circle()
                    .foregroundColor(Color(hex: language.color!))
                    .frame(width: circleSize, height: circleSize)
            }
        }
    }
}

struct RepositoryListContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListContentView(repoType: RepositoryType.New())
    }
}
