//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine


struct CatFact: Decodable {
    var _id: String
    var text: String
}

struct ErrorForAlert: Error, Identifiable {
    var id = UUID()
    let title: String = "Error"
    var message = "Please try again later."
    
    init(message: String) {
        id = UUID()
        self.message = message
    }
}

final class DataTaskPublisher: ObservableObject {
    @Published var dataToView = [CatFact]()
    @Published var errorForAlert: ErrorForAlert?
    var cancellbales: Set<AnyCancellable> = []
    
    func fetch() {
        let url = URL(string: "https://cat-fact.herokuapp.com/facts")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ (data: Data, response: URLResponse) in
                data
            }
            .decode(type: [CatFact].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    errorForAlert = ErrorForAlert(message: "Details: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] catFact in
                dataToView = catFact
            })
            .store(in: &cancellbales)
    }
    
}
