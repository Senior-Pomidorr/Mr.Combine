//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ServerError: Identifiable, Error {
    let id = UUID()
    var description = "There was a server error while retrieving values."
}

final class ViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var error: ServerError?
    let dataIn = ["Result 1", "Result 2", "Server Error", "Result 5"]
    
    func fetch() {
        _ = dataIn.publisher
            .tryMap({ item in
                if item.contains("Error") {
                    throw ServerError()
            }
                return item
            })
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error as? ServerError
                }
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
