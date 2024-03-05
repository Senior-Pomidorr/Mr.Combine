//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct UserId: Identifiable {
    let id = UUID()
    var email: String
    var name: String
}

final class ViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var criteria = ""
    var noResults = "No results found"
    let dataIn = ["Result 1", "Result 2", "Result 3", "Result 4", "Result 5"]
    
    func search() {
        dataToView.removeAll()
        
        _ = dataIn.publisher
            .filter { $0.contains(criteria) }
            .replaceEmpty(with: noResults)
            .sink(receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    dataToView.append(value)
            })
    }
}
