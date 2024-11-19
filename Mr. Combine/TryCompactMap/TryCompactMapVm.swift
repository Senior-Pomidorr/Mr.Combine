//
//  TryCompactMapVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 19.11.2024.
//

import Foundation
import Combine

class TryCompactMapVm: ObservableObject {
    @Published var data: [String] = []
    @Published var error: ErrorForAlerts?
    var cancellable: AnyCancellable?
    var dataIn = ["Value 1", nil, "Value 3", nil, "Value 5"]
    
    func fetch() {
        cancellable = dataIn.publisher
            .tryCompactMap { value in
                if value == "Invalid" {
                    throw ErrorForAlerts(message: "Invalid value")
                }
                return value
            }
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error as? ErrorForAlerts
                }
            } receiveValue: { [unowned self] value in
                self.data.append(value)
            }
    }
    
    func simulateError() {
        self.dataIn.append("Invalid")
    }
    
    deinit {
        self.cancellable?.cancel()
    }
}
