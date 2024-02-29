//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var itemCount = 5.0
    
    func fetch() {
        data.removeAll()
        
        let fetchedData = ["Result 1", "Result 2", "Result 3", "Result 4", "Result 5", "Result 6", "Result 7", "Result 8", "Result 9", "Result 10"]
        
        _ = fetchedData.publisher
            .prefix(Int(itemCount))
            .sink(receiveValue: { [unowned self] result in
                data.append(result)
            })
    }
}
