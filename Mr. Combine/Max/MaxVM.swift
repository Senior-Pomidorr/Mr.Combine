//
//  MaxVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 17.11.2024.
//
/* The max operator will republish just the maximum value that it received from the upstream publisher. If the max operator receives 10 items,
 it’ll find the maximum item and publish just that one item. If you were to sort your items in descending order then max would take the item at
 the top.
 It’s important to note that the max operator publishes the maximum item ONLY when the upstream publisher has finished with all of its items. */

import Foundation

class MaxVM: ObservableObject {
    @Published var dataString: [String] = []
    @Published var dataNumberes: [Int] = []
    @Published var maxString = ""
    @Published var maxNumber: Int = 0
    
    func fetch() {
        let dataIn = ["Aardvark", "Zebra", "Elephant"]
        dataString = dataIn
        dataString.publisher
            .max()
            .assign(to: &$maxString)
        
        let dataInNumberes = [37, 245, 764, 578, 284]
        dataNumberes = dataInNumberes
        dataNumberes.publisher
            .max()
            .assign(to: &$maxNumber)
    }
    
    private func update() {
        maxString = dataString.max() ?? ""
        maxNumber = dataNumberes.max() ?? 0
    }
    
    deinit {
        print("Unloaded Max_ViewModel")
    }
}
