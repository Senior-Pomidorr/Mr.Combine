//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import Foundation
import Combine

class YourFirstPipeline: ObservableObject {
    @Published var firstName: String = ""
    @Published var secondName: String = ""
    @Published var firstValidationName = ""
    @Published var secondValidationName = ""
    @Published var status: String = ""
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $firstName
            .map { $0.isEmpty ? "No name" : "Have name - OK!" }
            .sink { [unowned self] value in
                firstValidationName = value
            }
            .store(in: &cancellable)
        
        $secondName
            .map{ $0.isEmpty ? "No name": "Have name - OK!"}
            .sink { [unowned self] value in
                secondValidationName = value
            }
            .store(in: &cancellable)
    }
    
//    func refreshData() {
//        data = "Refreshed Data"
//    }
//    
    func cancelAllValidations() {
        cancellable.removeAll()
    }
}
