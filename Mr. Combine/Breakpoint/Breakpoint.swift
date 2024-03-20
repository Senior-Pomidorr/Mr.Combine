//
//  Breakpoint.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import Combine

final class BreakpointVM: ObservableObject {
    @Published var dataToView = [String]()
    var dataIn = ["Mercury", "Venus", "%Haley's Comet%", "Earth"].publisher
    
    func fetch() {
        _ = dataIn
            .breakpoint(receiveSubscription: { value in
                print("Subscriber was connected")
                return false
            }, receiveOutput: { value in
                print("Value in \(value) came through pipeline")
                return value.contains("%")
            }, receiveCompletion: { value in
                print("Pipeline is about to complete")
                return false
            })
            .sink(receiveCompletion: { completion in
                print("Pipeline completed")
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
