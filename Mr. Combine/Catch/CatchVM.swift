//
//  CatchVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import Foundation
import Combine

struct BombError: Identifiable, Error {
    var id = UUID()
    var description = "Error was here!"
}

final class CatchVM: ObservableObject {
    @Published var dataToView = [String]()
    let data = ["Value 1", "Value 2", "Value 3", "🧨", "Value 4", "Value 5"].publisher
    
    func fetch() {
        _ = data
            .tryMap{ value in
                if value == "🧨" {
                    throw BombError()
                }
                return value
            }
            .catch({ error in
                Just("Error found")
            })
            .sink(receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
