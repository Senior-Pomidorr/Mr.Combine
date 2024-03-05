//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct InvalidValueError: Identifiable, Error {
    let id = UUID()
    var description = "There was a server error while retrieving values."
}

final class ViewModel: ObservableObject {
    @Published var error: InvalidValueError?
    @Published var states: [String] = []
    
    func getPipelines(westernStates: Bool) -> AnyPublisher<String, Error> {
        if westernStates {
            ["Utah", "Nevada", "Colorado", "🧨", "Idaho"].publisher
                .tryMap { item in
                    if item == "🧨" {
                        throw InvalidValueError()
                    }
                    return item
                }
                .eraseToAnyPublisher()
        } else {
             ["Vermont", "New Hampshire", "Maine", "🧨", "Rhode Island"].publisher
                .map { item in
                    if item == "🧨" {
                        return "Montana"
                    }
                    return item
                }
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetch(westernStates: Bool) {
        states.removeAll()
        
        _ = getPipelines(westernStates: westernStates)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error as? InvalidValueError
                }
            }, receiveValue: { [unowned self] value in
                states.append(value)
            })
    }
}
