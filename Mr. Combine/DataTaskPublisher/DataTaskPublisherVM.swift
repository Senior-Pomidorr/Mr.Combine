//
//  DataTaskPublisherVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 13.11.2024.
//

import Foundation
import Combine

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct ErrorForAlerts: Error, Identifiable {
    var id: UUID { UUID() }
    let title: String = ""
    let message: String
}

class DataTaskPublisherVM: ObservableObject {
    @Published var data: [Post] = []
    @Published var errorForAlert: ErrorForAlerts?
    var cancellabeles: Set<AnyCancellable> = []
    var urlString = "https://jsonplaceholder.typicode.com/posts"
    
    func fetch() {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data: Data, response: URLResponse) in
                    data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    errorForAlert = ErrorForAlerts(message: error.localizedDescription)
                }
            } receiveValue: { [unowned self] value in
                self.data = value
            }
            .store(in: &cancellabeles)
    }
    
    func simulateErrorURL() {
        urlString = "https://jsonplaceholder.typicode.com/postssdf"
        fetch()
    }
    
    func correctUrl() {
        urlString = "https://jsonplaceholder.typicode.com/posts"
        fetch()
    }
}
