//
//  CollectByModel.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI
import Combine


final class CollectByModel: ObservableObject {
    @Published var players: [String] = []
    @Published var teamSize = 2.0
    @Published var teams: [[String]] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
       $teamSize
            .sink { [unowned self] value in
                createTeams(with: Int(value))
            }
            .store(in: &cancellables)
    }
    
    func fetch() {
        players = ["Mattie", "Chelsea", "Morgan", "Chase", "Kristin", "Beth", "Alex", "Ivan", "Hugo", "Rod", "Lila", "Chris"]
        createTeams(with: Int(teamSize))
    }
    
    func createTeams(with size: Int) {
        teams.removeAll()
        
        _ = players.publisher
            .collect(size)
            .sink(receiveValue: { [unowned self] team in
                teams.append(team)
            })
        
        
        
    }
    
   
}
