//
//  Network.swift
//  RemoteData
//
//  Created by Андрей Худик on 8/29/23.
//

import Foundation

class ApiService {
    func fetchJokes() async throws -> [Joke] {
        let endPoint = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: endPoint) else {
            throw ApiError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidRespone
        }
        do {
            let convertedData = try JSONDecoder().decode(Joke.self, from: data)
            return [convertedData]
        } catch {
            throw ApiError.unexpextedError
        }
    }
}

struct Joke: Decodable {
    let value: String
    let id: String
}

enum ApiError: Error {
    case invalidUrl
    case invalidRespone
    case unexpextedError
}
