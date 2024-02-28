//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var number = ""
    @State private var checkNumbers = false
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Try MAX",
                           subtitle: "Introduction",
                           desc: "MAX")
                
                List(vm.profiles) { profile in
                    HStack {
                        Text(profile.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(profile.city)
                            .foregroundStyle(.secondary)
                    }
                }
                Text("Max city: -\(vm.maxValue)")
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
