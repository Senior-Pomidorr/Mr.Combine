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
                HeaderView("Try Scan",
                           subtitle: "Introduction",
                           desc: "Try Scan")
                
                
                List(vm.states, id: \.self) { item in
                    Text(item)
                }
            }
            .font(.title)
        }
        .alert(item: $vm.error, content: { error in
            Alert(title: Text("Error"), message: Text(error.description))
        })
        .onAppear() {
            vm.scan()
        }
    }
}



#Preview {
    NavigationStack {
        ContentView()
    }
}
