//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class JustIntroViewModel: ObservableObject {
    @Published var dataToView = [String]()
    var cancellable: Set<AnyCancellable> = []
    
    func fetch() {
        var dataIn = ["Paul", "Lem", "Scott", "Chris", "Kaya", "Mark", "Adam", "Jared"]
        dataIn.publisher
            .sink { value in
                print(value)
            } receiveValue: { [unowned self] newItem in
                self.dataToView.append(newItem)
            }
            .store(in: &cancellable)
        
    }
    
}
