//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine


final class AllSatisfy: ObservableObject {
    @Published var numbers = [Int]()
    @Published var allFibanachiNumbers = false
    var cancellbales: Set<AnyCancellable> = []
    
    func allFibanachiCheck() {
        let fibanachiNumbers = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
        numbers.publisher
            .allSatisfy { number in
                fibanachiNumbers.contains(number)
            }
            .assign(to: &$allFibanachiNumbers)
    }
    
    func add(number: String) {
        if number.isEmpty { return }
        numbers.append(Int(number) ?? 0)
    }
    
}
