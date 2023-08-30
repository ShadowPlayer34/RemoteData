//
//  FavJokeRow.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/30/23.
//

import SwiftUI

struct OnlyFavJokeRow: View {
    @Environment(\.managedObjectContext) var context
    var favJoke: FavJokes
    var body: some View {
        HStack {
            Text(favJoke.value ?? "")
            Spacer()
            Button {
                context.delete(favJoke)
                try? context.save()
            } label: {
                Image(systemName: "star.fill")
            }
        }
    }
}
