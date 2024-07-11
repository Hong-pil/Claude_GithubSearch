//
//  Search.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import Moya
import ComposableArchitecture

@Reducer
struct Search {
    struct State: Equatable {
        var query: String = ""
        var repositories: [Repository] = []
        var isLoading: Bool = false
    }
    
    enum Action {
        case queryChanged(String)
        case search
        case searchResponse(Result<SearchResponse, Error>)
    }
    
    @Dependency(\.gitHubService) var gitHubService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .queryChanged(let query):
                state.query = query
                return .none
                
            case .search:
                state.isLoading = true
                return .run { [query = state.query] send in
                    do {
                        let response = try await gitHubService.searchRepositories(query)
                        await send(.searchResponse(.success(response)))
                    } catch {
                        await send(.searchResponse(.failure(error)))
                    }
                }
                
            case .searchResponse(.success(let response)):
                state.repositories = response.items
                state.isLoading = false
                return .none
                
            case .searchResponse(.failure):
                state.isLoading = false
                state.repositories = []
                return .none
            }
        }
    }
}
