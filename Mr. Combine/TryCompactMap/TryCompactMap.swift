//
//  TryCompactMap.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 19.11.2024.
//

import SwiftUI

struct TryCompactMap: View {
    @StateObject private var vm = TryCompactMapVm()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryCompactMap",
                       subtitle: "Introduction",
                       desc: "Use tryCompactMap to remove nils but also have the option to throw an error.")
            Button("Simulate error") {
                vm.simulateError()
            }
            List(vm.data, id: \.self) { item in
                Text(item)
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"), message: Text(error.message))
        }
        .onAppear {
            vm.fetch()
        }
    }
}

#Preview {
    TryCompactMap()
}
