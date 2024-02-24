//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class JustIntroViewModel: ObservableObject {
    @Published var data = [String]()
    @Published var interval: Double = 1
    var timerCancellable: AnyCancellable?
    var intervalCancellable: AnyCancellable?
    var timeInterval = DateFormatter()
    
    init() {
        timeInterval.dateFormat = "HH:mm:ss.SSS"
        
        intervalCancellable = $interval
            .dropFirst()
            .sink(receiveValue: { [unowned self] interval in
                timerCancellable?.cancel()
                data.removeAll()
                start()
            })
    }
    
    func start() {
        timerCancellable = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [unowned self] datum in
                data.append(timeInterval.string(from: datum))
            })
    }
    
    func stop() {
        timerCancellable?.cancel()
        data.removeAll()
    }
    
}
