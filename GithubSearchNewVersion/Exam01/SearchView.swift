//
//  SearchView.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    let store: StoreOf<Search>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                TextField("GitHub 레포지토리 검색", text: viewStore.binding(
                    get: \.query,
                    send: Search.Action.queryChanged
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button("검색") {
                    viewStore.send(.search)
                }
                .disabled(viewStore.query.isEmpty)
                
                if viewStore.isLoading {
                    ProgressView()
                } else {
                    List(viewStore.repositories) { repo in
                        VStack(alignment: .leading) {
                            Text(repo.name).font(.headline)
                            Text(repo.fullName).font(.subheadline)
                            if let description = repo.description {
                                Text(description).font(.body)
                            }
                            Text("Stars: \(repo.stargazersCount)").font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("GitHub 검색")
        }
    }
}

//#Preview {
//    SearchView()
//}
