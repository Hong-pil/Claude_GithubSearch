//
//  GithubSearchNewVersionApp.swift
//  GithubSearchNewVersion
//
//  Created by psynet on 7/11/24.
//

import SwiftUI
import ComposableArchitecture

/**
 * [Ref] https://claude.ai/chat/f3e557be-05cf-40e7-b293-86a58cce6af4
 */

@main
struct GithubSearchNewVersionApp: App {
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
//            SwitchStore(store) {
//                CaseLet(state: /GitHubSearchCoordinator.State.search, action: GitHubSearchCoordinator.Action.search) { searchStore in
//                    SearchView(store: searchStore)
//                }
//            }
            
            SearchView(
                store: Store(initialState: Search.State()) {
                    Search()
                }
            )
            
        }
    }
}
