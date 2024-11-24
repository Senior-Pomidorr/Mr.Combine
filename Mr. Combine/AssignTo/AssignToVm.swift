//
//  AssignToVm.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/10/24.
//

import Foundation
import Combine

final class AssignToVm: ObservableObject {
    @Published var name = ""
    @Published var greeting = ""
    
    init() {
        $name
            .map { [unowned self] name in
                createGreeting(with: name)
            }
            .assign(to: &$greeting)
    }
    
    func fetch(name: String) {
        self.name = name
    }
    
    func createGreeting(with name: String) -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        var prefix = ""
        
        switch hour {
        case 0..<12:
            prefix = "Good Morning, "
        case 12..<18:
            prefix = "Good Afternoon, "
        default:
            prefix = "Godd Evening. "
        }
        return prefix + name
    }
    
    deinit {
        print("Unloaded AssignTo_ViewModel")
    }
}
