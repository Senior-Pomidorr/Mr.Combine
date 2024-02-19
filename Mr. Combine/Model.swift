//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import Foundation
import Combine

class YourFirstPipeline: ObservableObject {
    @Published var name: String = ""
    @Published var validation: String = ""
    var cancellable: AnyCancellable?
    
    init() {
       _ = $name
            .map { $0.isEmpty ? "no text" : "OK" }
            .sink { [unowned self] value in
                self.validation = value
            }
    }
}
