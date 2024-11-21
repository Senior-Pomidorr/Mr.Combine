//
//  FirstWhereModel.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import Foundation
import Combine

final class FirstWhereModel: ObservableObject {
    @Published var criteria = ""
    @Published var deviceList: [String] = []
    @Published var firstFound = ""
    private var criteriaCancellable: AnyCancellable?
    
    init() {
        criteriaCancellable = $criteria
            .sink(receiveValue: { [unowned self] value in
                findFirst(criteria: value)
            })
    }
    
    func fetch() {
        deviceList = ["iPhone 4", "iPhone 15", "iPad Pro (14-inch)", "MacBook Pro 20-inch"]
    }
    
    func findFirst(criteria: String) {
        deviceList.publisher
            .first { device in
                device.contains(criteria)
            }
            .replaceEmpty(with: "Nothing found")
            .assign(to: &$firstFound)
    }
}
