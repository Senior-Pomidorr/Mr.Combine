//
//  AssigntToView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/10/24.
//

import SwiftUI

struct AssigntToView: View {
    @StateObject private var vm = AssignToVm()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Assign To",
                           subtitle: "Introduction",
                           desc: "The assign(to:) subscriber is very specific to JUST @Published  properties. It will easily allow you to add the value that come    down the pipeline to your published properties which will then     notify and update your views.")
                HStack {
                    TextField("Enter your name", text: $vm.name)
                        .padding(.horizontal)
                }
                Text(vm.greeting)
                
                Spacer(minLength: 0)
            }
            .font(.title)
            .onAppear() {
                vm.fetch(name: vm.name)
            }
        }
    }
}

#Preview {
    AssigntToView()
}
