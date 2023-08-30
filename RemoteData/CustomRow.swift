//
//  CustomRow.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/30/23.
//

import SwiftUI

struct CustomRow: View {
    // TODO: Take favorite from storage
    var joke: Joke
    @State var isFavorite: Bool = false
    var body: some View {
        HStack {
            Text(joke.value)
            Spacer()
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
            }
        }
    }
}

#Preview {
    CustomRow(joke: Joke(value: "", id: ""))
}
