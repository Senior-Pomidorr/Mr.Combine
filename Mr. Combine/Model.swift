//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class FutureIntroViewModel: ObservableObject {
    @Published var hello = ""
    @Published var goodbye = ""
    private var goodbyeCancellable: AnyCancellable?
    private var futurePublisher = Deferred {
        Future<String, Never> { success in
            success(Result.success("Say hello!"))
            print("Say Hello!")
        }
    }
    
    func sayHello() {
        futurePublisher
            .assign(to: &$hello)
    }
    
    func sayGoodbye() {
        let futurePablisher = Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success("Goodbye my friend!"))
            }
        }
        
        goodbyeCancellable = futurePablisher
            .sink(receiveValue: { [unowned self] message in
                goodbye = message
            })
    }
}
