//
//  TimerVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 12.11.2024.
//

import Foundation
import Combine

class TimerVM: ObservableObject {
    @Published var data: [String] = []
    @Published var interval: Double = 1
    let timerFormatter = DateFormatter()
    
    private var timerCancellabale: AnyCancellable?
    private var intervalCancellable: AnyCancellable?
    
    init() {
        timerFormatter.dateFormat = "HH:mm:ss.SSS"
        intervalCancellable = $interval
            .dropFirst()
            .sink { [unowned self] value in
                // Restart the timer pipeline
                timerCancellabale?.cancel()
                data.removeAll()
                start()
            }
        
    }
    func start() {
        timerCancellabale = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect() //The autoconnect operator seen here allows the Timer to automatically start publishing items.
            .sink(receiveValue: { [unowned self] value in
                data.append(timerFormatter.string(from: value))
            })
        
    }
}
