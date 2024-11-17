//
//  TryContainsView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.
//

import SwiftUI

struct TryContainsView: View {
    @StateObject private var vm = TryContainsVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryContains",
                       subtitle: "Introduction",
                       desc: "The tryContains(where: ) operator works like contains(where: ) except now the subscriber can also receive an error in addition to a true or false.")
            Text("Look for Salt Water in:")
            
            Picker("Place", selection: $vm.place) {
                Text("Nevada").tag("Nevada")
                Text("Utah").tag("Utah")
                Text("Mars").tag("Mars")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Search") {
                vm.search()
            }
            
            Text("Result: \(vm.result)")
        }
        .font(.title)
        .alert(item: $vm.error) { alertData in
            Alert(title: Text("Invalid Selection"))
        }
    }
}

#Preview {
    TryContainsView()
}
