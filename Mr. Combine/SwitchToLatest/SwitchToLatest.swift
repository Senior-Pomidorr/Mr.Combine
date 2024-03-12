//
//  SwitchToLatest.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import Foundation
import Combine

struct NameResultTwo: Decodable {
    var name = ""
    var gender = ""
    var probability = 0.0
}

//«You use switchToLatest when you have a pipeline that has publishers being sent downstream. If you looked at the flatMap operator you will understand this concept of a publisher of publishers. Instead of values going through your pipeline, it’s publishers. And those publishers are also publishing values on their own. With the flatMap operator, you can collect ALL of the values these publishers are emitting and send them all downstream.  But maybe you don’t want ALL of the values that ALL of these publishers emit. Instead of having these publishers run at the same time, maybe you want just the latest publisher that came through to run and cancel out all the other ones that are still running that came before it. And that is what the switchToLatest operator is for. It’s kind of similar to combineLatest, where only the last value that came through is used. This is using the last publisher that came through.»


final class SwitchToLatest: ObservableObject {
    @Published var names = ["Kelly", "Madison", "Pat", "Alexus", "Taylor", "Tracy"]
    @Published var nameResult: [NameResultTwo] = .init()
    var fetchNameDetails = PassthroughSubject<String, Never>()
    private var cancellable: Set<AnyCancellable> = .init()
    
    init() {
        fetchNameDetails
            .map { name -> (String, URL) in
                return (name, URL(string: "https://api.genderize.io/?name=\(name)")!)
            }
            .map { (name, url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: NameResultTwo.self, decoder: JSONDecoder())
                    .replaceError(with: NameResultTwo(name: name, gender: "Error"))
                    .delay(for: 0.5, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
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
    

