//
//  SinkReceiveVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/10/24.
//

import Foundation
import Combine

/* «The sink subscriber will allow you to just receive values and do anything you want with them.
    There is also an option to run code when the pipeline completes, whether it completed from an error or just naturally.»
 */

final class SinkReceiveVM: ObservableObject {
    @Published var newName = ""
    @Published var aToM: [String] = .init()
    @Published var nToz: [String] = .init()
    var cancellable: AnyCancellable?
    
    let names = ["Joe", "Nick", "Ramona", "Brad", "Mark", "Paul", "Sean", "Alice", "Kaya", "Emily"]
    
    init() {
        cancellable = $newName
            .dropFirst()
            .sink { [unowned self] value in
                let firstChar = value.prefix(1)
                if firstChar < "M" {
                    aToM.append(value)
                } else {
                    nToz.append(value)
                }
            }
            /*If the value coming through the pipeline was always assigned to the same @Published property,
              you could use the assign(to:) subscriber instead.*/
    }
    
    func fetch() {
        newName = names.randomElement()!
    }
    
    func clear() {
        aToM.removeAll()
        nToz.removeAll()
    }
}
