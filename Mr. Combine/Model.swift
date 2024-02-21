//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

enum InvalidAgeError: String, Error, Identifiable {
    var id: String { rawValue }
    case lessThanZero = "Cannot be less than zero"
    case moreThanOneHundred = "Cannot be more than 100"
}


class Validators {
    static func validateAgePublisher(age: Int) -> AnyPublisher<Int, InvalidAgeError> {
        if age < 0 {
            return Fail(error: InvalidAgeError.lessThanZero)
                .eraseToAnyPublisher()
        } else if age > 100 {
            return Fail(error: InvalidAgeError.moreThanOneHundred)
                .eraseToAnyPublisher()
        }
        
        return Just(age)
            .setFailureType(to: InvalidAgeError.self)
            .eraseToAnyPublisher()
    }
}

class FailIntroViewMode: ObservableObject {
    @Published var age = 0
    @Published var error: InvalidAgeError?
    
    func save(age: Int) {
        _ = Validators.validateAgePublisher(age: age)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { [unowned self] age in
                self.age = age
            })
    }
}













class FailInttroViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    
    func fetch() {
        let dataIn = ["Value 1", "Value 2", "Value 3", "🧨", "Value 5", "Value 6"]
        
        _ = dataIn.publisher
            .tryMap { item in
                if item == "🧨" {
                    print("Bomb DetectedError")
                }
                return item
            }
            .catch({ (error) in
                Empty(completeImmediately: true)
            })
            .sink(receiveValue: { [unowned self] item in
                dataToView.append(item)
            })
    }
}
