//
//  TryFilter.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 20.11.2024.
//

import SwiftUI

struct TryFilter: View {
    @StateObject private var vm = TryFilterVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryFilter",
                       subtitle: "Introduction",
                       desc: "The tryFilter operator will republished items that match your criteria or can throw an error that will cancel the pipeline.")
            HStack(spacing: 40.0) {
                Button("Animals") { vm.filterData(criteria: "Animal") }
                Button("People") { vm.filterData(criteria: "Person") }
                Button("All") { vm.filterData(criteria: " ") }
            }
            List(vm.dataOut, id: \.self) { datum in
                Text(datum)
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"), message: Text(error.description))
        }
    }
}

#Preview {
    TryFilter()
}
