//
//  OutputInVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import Foundation
import Combine

struct Animal: Identifiable {
    let id = UUID()
    var index = 0
    var name = ""
}

final class OutputInVM: ObservableObject {
    @Published var startIndex = 0
    @Published var endIndex = 5
    @Published var animals: [Animal] = .init()
    private var cancellabele: Set<AnyCancellable> = .init()
    let cache = [Animal(index: 0, name: "Chimpanzee"),
                 Animal(index: 1, name: "Elephant"),
                 Animal(index: 2, name: "Parrot"),
                 Animal(index: 3, name: "Dolphin"),
                 Animal(index: 4, name: "Pig"),
                 Animal(index: 5, name: "Octopus")]
    
    init() {
        $startIndex
            .map { [unowned self] index in
                if index < 0 {
                    return 0
                } else if index > endIndex {
                    return endIndex
                }
                return index
            }
            .sink { [unowned self] index in
                getAnimals(between: index, end: endIndex)
            }
            .store(in: &cancellabele)
        
        $endIndex
            .map { [unowned self] index in
                index < startIndex ? startIndex : index
            }
            .sink { [unowned self] index in
                getAnimals(between: startIndex, end: index)
            }
            .store(in: &cancellabele)
    }
    
    func getAnimals(between start: Int, end: Int) {
        animals.removeAll()
        
        cache.publisher
            .output(in: start...end)
            .sink { [unowned self] animal in
                animals.append(animal)
            }
            .store(in: &cancellabele)
    }
    
}

