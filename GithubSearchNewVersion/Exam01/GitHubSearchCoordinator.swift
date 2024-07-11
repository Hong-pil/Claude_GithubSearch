//
//  GitHubSearchCoordinator.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import ComposableArchitecture

struct GitHubSearchCoordinator: Reducer {
    enum State: Equatable {
        case search(Search.State)
    }
    
    enum Action {
        case search(Search.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /State.search, action: /Action.search) {
            Search()
        }
    }
}
