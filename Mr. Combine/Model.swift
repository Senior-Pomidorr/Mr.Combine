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
    @Published var filtredData: [String] = []
    let dataIn = ["Person 1", "Person 2", "Animal 1", "Person 3", "Animal 2", "Animal 3"]
    private var cancellable: AnyCancellable?
    
    init() {
        filterData(criteria: " ")
    }
    
    func filterData(criteria: String) {
        filtredData.removeAll()
        
        cancellable = dataIn.publisher
            .filter({ item -> Bool in
                item.contains(criteria)
            })
            .sink(receiveValue: { [unowned self] value in
                filtredData.append(value)
            })
    }
}
