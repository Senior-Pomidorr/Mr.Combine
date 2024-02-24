//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ErrorForAlert: Error, Identifiable {
    let id = UUID()
    var title = ""
    var message: String
    
    init(message: String) {
        self.message = message
    }
}



final class DataTaskPublisher: ObservableObject {
    @Published var dataToView: Image?
    @Published var errorForAlert: ErrorForAlert?
    var cancellbales: Set<AnyCancellable> = []
    
    func fetch() {
        let url = URL(string: "https://images.unsplash.com/photo-1708721205486-dd5afb8cd39e?q=80&w=2663&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ (data: Data, response: URLResponse) in
                data
            }
            .tryMap({ data in
                guard let image = UIImage(data: data) else { throw
                    ErrorForAlert(message: "Did not receive a valid image.")
                }
                return Image(uiImage: image)
            })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    errorForAlert = ErrorForAlert(message: "Details: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] image in
                dataToView = image
            })
            .store(in: &cancellbales)
    }
    
}
