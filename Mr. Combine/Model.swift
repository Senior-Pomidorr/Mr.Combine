//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct InvalidNumberError: Error, Identifiable {
    var id = UUID()
}

final class AllSatisfy: ObservableObject {
    @Published var place = "Nevada"
    @Published var result = ""
    @Published var invalidSelectionError: InvalidNumberError?
    let incomingData = ["Places with Slat Water", "Utah", "California"]
    
    func search() {
       _ = incomingData.publisher
            .tryContains(where: { [unowned self] item -> Bool in
                if place == "Mars" {
                    throw InvalidNumberError()
                }
                return item == place
            })
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .failure(let error):
                    self.invalidSelectionError = error as? InvalidNumberError
                default:
                    break
                }
            }, receiveValue: { [unowned self] result in
                self.result = result ? "Found" : "Not Found"
            })
    }
}
