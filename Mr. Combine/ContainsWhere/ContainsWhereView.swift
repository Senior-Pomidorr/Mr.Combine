//
//  ContainsWhereVIew.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 14.11.2024.
//

import SwiftUI

struct ContainsWhereView: View {
    @StateObject private var vm = ContainsWhereVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Contains",
                       subtitle: "Where",
                       desc: "The contains(where:) operator will publish a true and finish thepipeline when an item coming through matches the criteria you specify within the closure it provides.")
            Group {
                Text(vm.fruitName)
                Toggle("Vitamin A", isOn: $vm.vitaminA)
                Toggle("Vitamin B", isOn: $vm.vitaminB)
                Toggle("Vitamin C", isOn: $vm.vitaminC)
            }
            .padding(.horizontal)
            Spacer()
        }
        .font(.title)
        .onAppear {
            vm.fetch()
        }
    }
}

#Preview {
    ContainsWhereView()
}
