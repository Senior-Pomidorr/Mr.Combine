//
//  ReduceViewModel.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import Foundation

final class ReduceViewModel: ObservableObject {
    @Published var longestAnimalName = ""
    @Published var animals: [String] = []
    let dataIn = ["elephant", "deer", "mouse", "hippopotamus", "rabbit", "aardvark"]
    
    
    func fetch() {
        _ = dataIn.publisher
            .sink(receiveValue: { [unowned self] value in
                animals.append(value)
            })
        
        dataIn.publisher
            .reduce("") { longestName, nextTime in
                if nextTime.count > longestName.count {
                    return nextTime
                }
                    return longestName
            }
            .assign(to: &$longestAnimalName)
    }
    
    deinit {
        print("Unloaded Reduce_ViewModel")
    }
}
