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
                HeaderView("Debounce",
                           subtitle: "Introduction",
                           desc: "debounce")
                
                TextField("name", text: $vm.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Text(vm.nameEntered)
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
