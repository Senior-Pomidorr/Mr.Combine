//
//  TryCompactMapVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 19.11.2024.
/*  Just like the compactMap except you are also allowed to throw an error inside the closure provided. This operator lets the pipeline know that a
 failure is possible. So when you add a sink subscriber, the pipeline will only allow you to add a sink(receiveCompletion:receiveValue:) as
 it expects you to handle possible failures.  */

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
        dataIn.removeAll()
        self.dataIn.append("Invalid")
        fetch()
    }
    
    deinit {
        self.cancellable?.cancel()
        print("Unloaded TryCompactMap_ViewModel")
    }
}
