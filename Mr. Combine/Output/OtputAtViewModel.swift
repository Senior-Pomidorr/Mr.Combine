//
//  OtputAtViewModel.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/7/24.
//

import Foundation
import Combine

final class OtputAtViewModel: ObservableObject {
    @Published var index = 0
    @Published var selection = ""
    @Published var animals = ["Chimpanzee", "Elephant", "Parrot", "Dolphin", "Pig", "Octopus"]
    private var cancellabele: AnyCancellable?
    
    init() {
        cancellabele = $index
            .sink(receiveValue: { [unowned self] in
                getAnimal(at: $0)
            })
    }
    
    func getAnimal(at index: Int) {
        animals.publisher
            .output(at: index)
            .assign(to: &$selection)
    }
    
    deinit {
        print("Unloaded Output_ViewModel")
    }
}
