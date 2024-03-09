//
//  SubscribeOnVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import Foundation
import Combine

final class SubscribeOnVM: ObservableObject {
    @Published var dataToView: [String] = .init()
    let dataIn = ["Which", "thread", "is", "used?"]
    
    func fetch() {
        _ = dataIn.publisher
            .map { item in
                print("map: Main THread? \(Thread.isMainThread)")
                return item
            }
            .handleEvents(receiveSubscription: { subscription in
                print("receiveSubscription: Main thread? \(Thread.isMainThread)")},
                          receiveOutput: { item in
                print("\(item) - receiveOutput: Main thread? \(Thread.isMainThread)")},
                          receiveCompletion: { completion in
                print("receiveCompletion: Main thread? \(Thread.isMainThread)")},
                          receiveCancel: {
                print("receiveCancel: Main thread? \(Thread.isMainThread)")},
                          receiveRequest: { demand in
                print("receiveRequest: Main thread? \(Thread.isMainThread)")
            })
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] item in
                dataToView.append(item)
            }
    }

}
