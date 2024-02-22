//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class JustIntroViewModel: ObservableObject {
    @Published var data = ""
    @Published var dataToView: [String] = []
    
    func fetch() {
        let dataIn = ["Julian", "Meredith", "Luan", "Daniel", "Marina"]
        
        _ = dataIn.publisher
            .sink(receiveValue: { data in
                self.dataToView.append(data)
            })
        
        if dataIn.count > 0 {
            Just(dataIn.randomElement() ?? "")
                .map { data in
                    data.uppercased()
                }
                .assign(to: &$data)
        }
        
    }
}
