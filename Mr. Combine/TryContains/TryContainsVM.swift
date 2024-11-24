//
//  TryContainsVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.
//

import Foundation
import Combine


class TryContainsVM: ObservableObject {
    @Published var place = ""
    @Published var result = ""
    @Published var error: InvalidValueErrorStruct?
    
    func search() {
        let incomingData = ["Places with Salt Water", "Utah", "California"]
        
        _ = incomingData.publisher
            .dropFirst()
            .tryContains(where: { [unowned self] value in
                if place == "Mars" {
                    throw InvalidValueErrorStruct()
                }
                return value == place
            })
            .sink(receiveCompletion: { completion in
                if case .failure(let failure) = completion {
                    self.error = failure as? InvalidValueErrorStruct
                }
            }, receiveValue: { value in
                self.result = value ? "Found" : "NotFound"
            })
    }
    
    deinit {
        print("Unloaded TryContainsWhere_ViewModel")
    }
}

extension TryContainsVM {
    struct InvalidValueErrorStruct: Identifiable, Error {
        var id = UUID()
    }
}
