//
//  MapErrorView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 24.11.2024.
//

import SwiftUI

struct MapErrorView: View {
    @StateObject private var vm = MapErrorVM()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("MapError",
                       subtitle: "Introduction",
                       desc: "The mapError operator provides a closure to receive an upstream error and then republish another error.")
            Button("Fetch Data") {
                vm.fetch()
            }
            List(vm.todos) { todo in
                Label(title: { Text(todo.title) },
                      icon: { Image(systemName: todo.completed ?
                                    "checkmark.circle.fill" :
                                        "circle") })
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"), message: Text(error.message))
        }
    }
}

#Preview {
    MapErrorView()
}
