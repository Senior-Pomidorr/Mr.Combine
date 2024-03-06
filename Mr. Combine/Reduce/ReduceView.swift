//
//  ReduceView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct ReduceView: View {
    @StateObject private var vm = ReduceViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Reduce",
                           subtitle: "Introduction",
                           desc: "Reduce")
                
                List(vm.animals, id: \.self) { item in
                    Text(item)
                }
                
                Text("Longest animal name:")
                + Text(" \(vm.longestAnimalName)")
                    .bold()
            
            }
            .font(.title)
        }
        .onAppear() {
            vm.fetch()
        }
    }
}

#Preview {
    ReduceView()
}
