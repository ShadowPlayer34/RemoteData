//
//  ContentView.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/29/23.
//

import SwiftUI

struct ContentView: View {
    private let api = ApiService()
    @FetchRequest(sortDescriptors: []) var favoriteJokes: FetchedResults<FavJokes>
    @State var jokes: [Joke] = []
    @State var isOnlyFavorities: Bool = false
    @State var isLoading: Bool = true
    @State var isError: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isOnlyFavorities.toggle()
                } label: {
                    Text(isOnlyFavorities ? "All" : "Favorites")
                }
                .padding()
            }
            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List {
                    if isOnlyFavorities {
                        ForEach(favoriteJokes) { joke in
                            OnlyFavJokeRow(favJoke: joke)
                        }
                    } else {
                        ForEach(jokes, id: \.id) { joke in
                            JokeRow(joke: joke)
                        }
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
        .alert("Unexpected network error", isPresented: $isError) {}
    }
    
    private func refresh() async {
        do {
            jokes = try await api.fetchJokes()
        } catch {
            isError = true
        }
    }
}

#Preview {
    ContentView()
}
