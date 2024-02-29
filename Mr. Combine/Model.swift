//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct TimeOutError: Error, Identifiable {
    let id = UUID()
    let title = "Timeout"
    let message = "Please try again later."
}

final class ViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var isFetching = false
    @Published var timeOutError: TimeOutError?
    private var cancellablle: AnyCancellable?
    
    func fetch() {
        isFetching = true
        
        let url = URL(string: "https://bigmountainstudio.com/nothing")!
        
        cancellablle = URLSession.shared.dataTaskPublisher(for: url)
            .timeout(.seconds(3), scheduler: RunLoop.main, customError: {
                URLError(.timedOut)
            })
            .map{ $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [unowned self] completion in
                isFetching = false
                if case .failure(let failure) = completion {
                    timeOutError = TimeOutError()
                }
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
    
}
