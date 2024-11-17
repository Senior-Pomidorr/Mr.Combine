//
//  ContainsWhereVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.
//

import Foundation
import Combine

fileprivate struct Fruit {
    var name: String
    var nutritionalInformation: String
}

class ContainsWhereVM: ObservableObject {
    @Published var fruitName = ""
    @Published var vitaminA = false
    @Published var vitaminB = false
    @Published var vitaminC = false
    
    func fetch() {
        let incomingData = [Fruit(name: "Apples", nutritionalInformation: "Vitamin A, Vitamin C")]
        _ = incomingData.publisher
            .sink(receiveValue: { [unowned self] fruit in
                self.fruitName = fruit.name
            })
        
        incomingData.publisher
            .contains { fruit in
                fruit.nutritionalInformation.contains("Vitamin A")
            }
            .assign(to: &$vitaminA)
        
        incomingData.publisher
            .contains { fruit in
                fruit.nutritionalInformation.contains("Vitamin B")
            }
            .assign(to: &$vitaminB)
        
        incomingData.publisher
            .contains { fruit in
                fruit.nutritionalInformation.contains("Vitamin C")
            }
            .assign(to: &$vitaminC)
    }
}
