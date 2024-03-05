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
                HeaderView("Replace Empty",
                           subtitle: "Introduction",
                           desc: "Replace Empty")
                HStack {
                    TextField("Enter text", text: $vm.criteria)
                    Button("Seatch") {
                        vm.search()
                    }
                }
                .padding()
                
                List(vm.dataToView, id: \.self) { item in
                    Text(item)
                        .foregroundStyle(item == vm.noResults ? .gray : .primary)
                }
            }
        }
        .font(.title)
    }
}



#Preview {
    NavigationStack {
        ContentView()
    }
}
