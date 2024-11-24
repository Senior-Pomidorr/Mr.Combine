//
//  CollectByTime.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import Foundation

import SwiftUI
import Combine


final class CollectByTime: ObservableObject {
    @Published var timeInterval = 0.5
    @Published var collections: [[String]] = []
    private var cancellables: Set<AnyCancellable> = []
    private var cancelTimer: AnyCancellable?
    
    init() {
        $timeInterval
            .sink { [unowned self] _ in
                fetch()
            }
            .store(in: &cancellables)
    }
    
    func fetch() {
        collections.removeAll()
        cancelTimer?.cancel()
        
        cancelTimer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .map{ _ in "🟢"  }
            .collect(.byTime(RunLoop.main, .seconds(timeInterval)))
            .sink(receiveValue: { [unowned self] item in
                collections.append(item)
            })
    }
    
    func stop() {
        collections.removeAll()
        cancelTimer?.cancel()
    }
    
    deinit {
        print("Unloaded CollectByTime_ViewModel")
    }
}

