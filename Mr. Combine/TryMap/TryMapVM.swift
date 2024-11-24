//
//  TryMapVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
/*  The tryMap operator is just like the map operator except it can throw errors. Use this if you believe items coming through could possibly
    cause an error. Errors thrown will finish the pipeline early. */

import Foundation
import Combine

class TryMapVM: ObservableObject {
    @Published var dataOut: [String] = []
    @Published var error: ErrorForAlerts?
    @Published var data = ["Value 1", "Value 2", "Value 3", "Value5"]
    var cacellabele = Set<AnyCancellable>()
    
    func fetch() {
        $data
            .flatMap { array in
                array.publisher
            }
            .tryMap { value in
                if value.lowercased().contains("error") {
                    throw ErrorForAlerts(message: "Server error 500")
                }
                return value
            }
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error as? ErrorForAlerts
                }
            } receiveValue: { [unowned self] value in
                self.dataOut.append(value)
            }
            .store(in: &cacellabele)
    }
    
    func simulateError() {
        data.append("Server Error 500")
    }
    
    deinit {
        print("Unloaded TryMap_ViewModel")
    }
}
