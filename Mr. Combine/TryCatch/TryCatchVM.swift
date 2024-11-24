//
//  TryCatchVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import Combine


//«If you want the ability of the catch operator but also want to be able to throw an error, then tryCatch is what you need.»


class TryCatch: ObservableObject {
    @Published var dataToView: [String] = .init()
    @Published var error: BombError?
    let dataIn = ["Value 1", "Value 2", "Value 3", "🧨", "Value 5", "Value 6"].publisher
    
    func fetch() {
        _ = dataIn
            .tryMap({ item in
                if item == "🧨" {
                    throw BombError()
                }
                return item
            })
            .tryCatch({ [unowned self] error in
                fetchAlternativeData()
            })
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error as? BombError;()
                }
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
    
    func fetchAlternativeData() -> AnyPublisher<String, Error> {
        ["Alternative Value 1", "Alternative Value 2", "🧨", "Alternative Value 4"].publisher
            .tryMap { item in
                if item == "🧨" {
                    throw BombError()
                }
                return item
            }
            .eraseToAnyPublisher()
    }
    
    deinit {
        print("Unloaded tryCatch_ViewModel")
    }
}
