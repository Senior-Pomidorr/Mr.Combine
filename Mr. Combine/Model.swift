//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct InvalidValueError: Error, Identifiable {
    let id = UUID()
    let description = "One of the values you entered is invalid and will have to be update"
}

final class ViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var invalidValueError: InvalidValueError?
    let dataIn = ["Value 1", nil, "Value 3", nil, "Value 5", "Invalid"]
    
    func fetch() {
        _ = dataIn.publisher
            .tryCompactMap { item in
                if item == "Invalid" {
                    throw InvalidValueError()
                }
                return item
            }
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.invalidValueError = error as? InvalidValueError
                }
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
