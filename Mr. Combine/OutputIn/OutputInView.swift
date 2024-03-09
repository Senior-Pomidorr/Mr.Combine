//
//  OutputInView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import SwiftUI

struct OutputInView: View {
    @StateObject private var vm = OutputInVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Output(In: )",
                           subtitle: "Introduction",
                           desc: "Output(In: )")
                
                Stepper("Start Index: \(vm.startIndex)", value: $vm.startIndex, in: 0...vm.animals.count)
                    .padding(.horizontal)
                Stepper("End Index: \(vm.endIndex)", value: $vm.endIndex, in: 0...vm.animals.count)
                    .padding(.horizontal)
                
                List(vm.animals) { animal in
                    Text(animal.name)
                }
            }
            .font(.title)
        }
    }
}

#Preview {
    OutputInView()
}
