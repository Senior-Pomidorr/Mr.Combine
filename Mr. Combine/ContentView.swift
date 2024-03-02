//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("removeDuplicates by:",
                           subtitle: "Introduction",
                           desc: "removeDuplicates by:")
                List(vm.filtredData) { data in
                    Text(data.email)
                }
                DescView("Notice that only duplicates that are one-after-another are removed")
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
