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
    var error = ""
}

final class AllSatisfy: ObservableObject {
    @Published var numbers = [Int]()
    @Published var allFibanachiNumbers = false
    @Published var invaliderror: InvalidNumberError?
    var cancellbales: Set<AnyCancellable> = []
    
    func allFibanachiCheck() {
        let fibanachiNumbers = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
        _ = numbers.publisher
            .tryAllSatisfy { number in
                if number > 144 {
                    throw InvalidNumberError()
                }
                return fibanachiNumbers.contains(number)
            }
            .sink { [unowned self] completion in
                switch completion {
                case .failure(let error):
                    self.invaliderror = error as? InvalidNumberError
                default:
                    break
                }
            } receiveValue: { [unowned self] value in
                allFibanachiNumbers = value
            }
    }
    
    func add(number: String) {
        if number.isEmpty { return }
        numbers.append(Int(number) ?? 0)
    }
    
}
