//
//  SetFailureTypeVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
/*  There are two types of pipelines. Pipelines that have publishers/operators that can throw errors and those that do not. The setFailureType is for those pipelines that do not throw errors. This operator doesn’t actually throw an error and it will not cause an error to be thrown later. It does not affect your pipeline in any way other than to change the type of your pipeline. Read more on the next page to understand what this means. */

import Foundation
import Combine

class SetFailureTypeVM: ObservableObject {
    @Published var states: [String] = []
    @Published var error: ErrorForAlert?
    private var cancellabele: AnyCancellable?
    
    func getPipline(condition: Bool) -> AnyPublisher<String, Error> {
        if condition {
            return ["Utah", "Nevada", "Colorado", "🧨", "Idaho"].publisher
                .tryMap { item -> String in
                    if item == "🧨" {
                        throw ErrorForAlert(description: "Set error falure type")
                    }
                    return item
                }
                .eraseToAnyPublisher()
        } else {
            return ["Vermont", "New Hampshire", "Maine", "🧨", "Rhode Island"].publisher
                .map { item -> String in
                    if item == "🧨" {
                        return "Massachusetts"
                    }
                    return item
                }
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetch(condition: Bool) {
        states.removeAll()
        
        cancellabele = getPipline(condition: condition)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let failure) = completion {
                    self.error = failure as? ErrorForAlert
                }
            }, receiveValue: { [unowned self] value in
                self.states.append(value)
            })
    }
    
    deinit {
        cancellabele?.cancel()
        print("Unloaded SetFailureType_ViewModel")
    }
}
