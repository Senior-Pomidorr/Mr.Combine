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
    let dataIn = ["Lem", "Lem", "Scott", "Scott", "Chris", "Mark", "Adam", "Jared", "Mark"]
    private var cancellable: AnyCancellable?
    
    func fetch() {
        cancellable = dataIn.publisher
            .removeDuplicates()
            .sink(receiveValue: { [unowned self] data in
                self.filtredData.append(data)
            })
    }
}
