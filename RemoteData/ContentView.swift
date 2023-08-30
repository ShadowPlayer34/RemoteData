//
//  ContentView.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/29/23.
//

import SwiftUI

struct ContentView: View {
    let api = ApiService()
    @State var jokes: [Joke] = []
    @State var isOnlyFavorities: Bool = false
    @State var isLoading: Bool = true
    @State var isError: Bool = false
    @State var errorReason: ApiError? = nil
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isOnlyFavorities.toggle()
                } label: {
                    Text(isOnlyFavorities ? "All" : "Favorites")
                }
            }
            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List {
                    ForEach(jokes, id: \.id) { joke in
                        CustomRow(joke: joke)
                    }
                }
                .listStyle(.grouped)
                .refreshable {
                    await refresh()
                }
            }
        }
        .task {
            isLoading = true
            await refresh()
            isLoading = false
        }
    }
    
    private func refresh() async {
        do {
            jokes = try await api.fetchJokes()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
