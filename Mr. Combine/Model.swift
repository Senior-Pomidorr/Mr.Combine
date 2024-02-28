//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine



//struct ViewModel: Error, Identifiable {
//    var id = UUID()
//}

final class ViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var maxValue = ""
    @Published var numbers: [Int] = []
    @Published var maxNumbers = 0
    
    func fetch() {
        let dataIn = ["Aardvark", "Zebra", "Elephant"]
        data = dataIn
        
        dataIn.publisher
            .max()
            .assign(to: &$maxValue)
        
        let dataInNumbers = [900, 245, 783]
        numbers = dataInNumbers
        dataInNumbers.publisher
            .max()
            .assign(to: &$maxNumbers)
    }
}
