//
//  OutputAtView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/7/24.
//  With the output(at:) operator, you can specify an index and when an item at that index comes through the pipeline it will be republished and the pipeline will finish. If you specify a number higher than the number of items that come through the pipeline before it finishes, then nothing is published. (You won’t get any index out-of-bounds errors.) */

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
