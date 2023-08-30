//
//  CustomRow.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/30/23.
//

import SwiftUI

struct JokeRow: View {
    @Environment(\.managedObjectContext) var context
    var joke: Joke?
    @State var favJoke: FavJokes?
    @State var isFavorite: Bool = false
    var body: some View {
        HStack {
            Text(joke?.value ?? favJoke?.value ?? "")
            Spacer()
            Button {
                isFavorite.toggle()
                if isFavorite {
                    favJoke = FavJokes(context: context)
                    favJoke?.value = joke?.value
                    try? context.save()
                } else {
                    guard let favJoke = favJoke else { return }
                    context.delete(favJoke)
                    try? context.save()
                }
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
            }
        }
        .task {
            if favJoke != nil {
                isFavorite = true
            }
        }
    }
}

//#Preview {
//    CustomRow(joke: Joke(value: "", id: ""))
//}
