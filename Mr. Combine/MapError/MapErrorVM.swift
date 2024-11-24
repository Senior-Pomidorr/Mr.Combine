//
//  MapErrorVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 24.11.2024.
//

import Foundation
import Combine

struct ToDo: Identifiable, Decodable {
    var id: Int
    var title: String
    var completed: Bool
}

struct ErrorForView: Error, Identifiable {
    var id = UUID()
    var message = ""
}

enum UrlResponseErrors: String, Error {
    case unknown = "Response wasn't recognized"
    case clientError = "Problem getting the information"
    case serverError = "Problem with the server"
    case decodeError = "Problem reading the returned data"
}

class MapErrorVM: ObservableObject {
    @Published var todos: [ToDo] = []
    @Published var error: ErrorForView?
    var cancellebale: AnyCancellable?
    
    func fetch() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/1/todos")!
        cancellebale = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, urlResponse in
                guard let response = urlResponse as? HTTPURLResponse else {
                    throw UrlResponseErrors.unknown
                }
                switch response.statusCode {
                case (400...499):
                    throw UrlResponseErrors.clientError
                case (500...599):
                    throw UrlResponseErrors.serverError
                default:
                   _ = UrlResponseErrors.unknown
                }
                return data
            })
            .decode(type: [ToDo].self, decoder: JSONDecoder())
            .mapError({ error -> UrlResponseErrors in
                if let response = error as? UrlResponseErrors {
                    return response
                } else {
                    return UrlResponseErrors.decodeError
                }
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] complition in
                if case .failure(let failure) = complition {
                    self.error = ErrorForView(message: failure.rawValue)
                }
            }, receiveValue: { [unowned self] value in
                self.todos = value
            })
    }
    
}
