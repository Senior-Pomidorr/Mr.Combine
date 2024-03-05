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
    var items = ["Utah", "Nevada", "Colorado", "🧨", "Idaho"]
    
    func scan() {
        _ = items.publisher
            .tryScan("Texas", { [unowned self] prevValue, currentValue in
                if currentValue == "🧨" {
                    throw InvalidValueError()
                }
                return prevValue + " " + currentValue
            })
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let failure) = completion {
                    if let err = failure as? InvalidValueError {
                        states.append(err.description + " " + "🧨")
                    }
                }
            }, receiveValue: { [unowned self] value in
                states.append(value)
            })
    }
}
