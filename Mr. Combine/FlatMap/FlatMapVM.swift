//
//  FlatMapVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import Foundation
import Combine

struct NameResult: Decodable {
    var name = ""
    var gender = ""
    var probability = 0.0
}

//«You are used to seeing a value of some sort sent down a pipeline. But what if you wanted to use that value coming down the pipeline to retrieve more data from another data source. You would essentially need a publisher within a publisher. The flatMap operator allows you to do this.»

final class FlatMapVM: ObservableObject {
    @Published var names = ["Kelly", "Madison", "Pat", "Alexus", "Taylor", "Tracy"]
    @Published var nameResult: [NameResult] = .init()
    private var cancellable: Set<AnyCancellable> = .init()
    
    func fetchResults() {
        names.publisher
            .map { name -> (String, URL) in
                return (name, URL(string: "https://api.genderize.io/?name=\(name)")!)
            }
            .flatMap { (name, url) -> AnyPublisher<NameResult, Never> in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map{ $0.data }
                    .decode(type: NameResult.self, decoder: JSONDecoder())
                    .replaceError(with: NameResult(name: "Not found", gender: "404"))
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                nameResult.append(value)
            }
            .store(in: &cancellable)
    }
    
    func removAll() {
        nameResult.removeAll()
    }
}
