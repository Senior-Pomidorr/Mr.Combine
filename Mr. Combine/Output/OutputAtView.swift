//
//  OutputAtView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/7/24.
//

import SwiftUI

struct OutputAtView: View {
    @StateObject private var vm = OtputAtViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Output(at: )",
                           subtitle: "Introduction",
                           desc: "Output(at: )")
                
                
                Stepper("Index: \(vm.index)", value: $vm.index, in: 0...vm.animals.count)
                    .padding()
                
                Text("Animal \(vm.selection)")
                    .italic()
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Smart Animals")
                    .bold()
                List(vm.animals, id: \.self) { animal in
                    Text(animal)
                }
            }
            .font(.title)
        }
    }
}

#Preview {
    OutputAtView()
}
