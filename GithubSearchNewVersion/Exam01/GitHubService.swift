//
//  GitHubService.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import ComposableArchitecture
import Moya

extension DependencyValues {
    var gitHubService: GitHubService {
        get { self[GitHubService.self] }
        set { self[GitHubService.self] = newValue }
    }
}

struct GitHubService {
    var searchRepositories: (String) async throws -> SearchResponse
}

extension GitHubService: DependencyKey {
    static let liveValue = Self(
        searchRepositories: { query in
            let provider = MoyaProvider<GitHubAPI>()
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(.searchRepositories(query)) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let searchResponse = try response.map(SearchResponse.self)
                            continuation.resume(returning: searchResponse)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    )
}
