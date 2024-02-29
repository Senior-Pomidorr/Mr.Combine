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
                HeaderView("Try prefix",
                           subtitle: "Introduction",
                           desc: "prefix")
                
                Text("Limit Results")
                Slider(value: $vm.itemCount, in: 1...10, step: 1)
                    .padding()
                Text(String(Int(vm.itemCount)))
                
                Button("Fetch Data") {
                    vm.fetch()
                }
                
                List(vm.data, id: \.self) { data in
                    Text(data)
                }
                Spacer(minLength: 0)
            }
            .font(.title)
        }
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
