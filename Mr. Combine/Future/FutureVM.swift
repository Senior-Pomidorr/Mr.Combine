//
//  FututreVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 11.11.2024.
//

import Foundation
import Combine

class FutureVM: ObservableObject {
    @Published var hello = ""
    @Published var goodbye = ""
    
    var cacncellable: AnyCancellable?
    
    func sayHello() {
        Future<String, Never> { promise in
            promise(.success("Hello world"))
        }
        .assign(to: &$hello)
    }
    
    func sayGoodbye() {
        cacncellable = Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(.success("Say goodbye!"))
            }
        }
        .sink { [unowned self] value in
            self.goodbye = value
        }
    }
    
}
