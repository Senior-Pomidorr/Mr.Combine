//
//  ContainsWhereVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.
//
/* This contains(where:) operator gives you a closure to specify your criteria to find a match. This could be useful where the items coming through the pipeline are not simple primitive types like a String or Int. Items that do not match the criteria are dropped (not published) and when the first item is a match, the boolean true is published.
   When the first match is found, the pipeline is finished/stopped.
   If no matches are found at the end of all the items, a boolean false is published and the pipeline is finished/stopped. */

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
    
    deinit {
        print("Unloaded ContainsWhere_ViewModel")
    }
}
