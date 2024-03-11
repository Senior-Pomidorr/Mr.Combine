//
//  AnyPublisherVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/11/24.
//

import Foundation
import Combine


//«The AnyPublisher object can represent, well, any publisher or operator. (Operators are a form of publishers.) When you create pipelines and want to store them in properties or return them from functions, their resulting types can bet pretty big because you will find they are nested. You can use AnyPublisher to turn these seemingly complex types into a simpler type.»

final class AnyPublisherVM: ObservableObject {
    @Published var home = true
    @Published var team: [String] = .init()
    private var cancellable: Set<AnyCancellable> = .init()
    
    init() {
        $home
            .sink { [unowned self] value in
                fetch(homeTeam: value)
            }
            .store(in: &cancellable)
    }
    
    func fetch(homeTeam: Bool) {
        team.removeAll()
        
        AppPublisher.teamPublisher(homeTeam: homeTeam)
            .sink { [unowned self] value in
                team.append(value)
            }
            .store(in: &cancellable)
    }
}


final class AppPublisher {
    static func teamPublisher(homeTeam: Bool) -> AnyPublisher<String, Never> {
        if homeTeam {
            return ["Stokton", "Malone", "Williams"].publisher
                .prepend("HOME TEAM")
                .eraseToAnyPublisher()
        } else {
            let url = URL(string: "https://www.nba.com/api/getteam?id=21")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: String.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .prepend("AWAY TEAM")
                .replaceError(with: "No players found")
                .eraseToAnyPublisher()
        }
    }
}
