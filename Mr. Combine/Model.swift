//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ServerError: Identifiable, Error {
    let id = UUID()
    var description = "There was a server error while retrieving values."
}

final class ViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var error: ServerError?
    let dataIn = ["Result 1", "Result 2", nil, "Server Error", nil, "Result 5"]
    
    func fetch() {
        _ = dataIn.publisher
            .replaceNil(with: "Nil was here")
            .sink(receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
