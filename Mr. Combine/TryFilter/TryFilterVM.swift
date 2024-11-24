//
//  TryFilterVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 20.11.2024.
//  The tryFilter operator works just like the filter operator except it also allows you to throw an error within the closure. //

import Combine
import Foundation

class TryFilterVM: ObservableObject {
    @Published var dataOut: [String] = []
    @Published var error: ErrorForAlert?
    let dataIn = ["Person 1", "Person 2", "Animal 1", "Person 3", "Animal 2", "Animal 3",
    "🧨"]
    private var cancellable: AnyCancellable?
    
    init() {
        filterData()
    }
    
    func filterData(criteria: String = "") {
        cancellable = dataIn.publisher
            .tryFilter({ value -> Bool in
                if value == "🧨" {
                    throw ErrorForAlert()
                }
                return value.contains(criteria)
            })
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let failure) = completion {
                    self.error = failure as? ErrorForAlert
                }
            }, receiveValue: { [unowned self] value in
                self.dataOut.append(value)
            })
    }
    
    deinit {
        print("Unloaded TryFilter_ViewModel")
    }
    
}
