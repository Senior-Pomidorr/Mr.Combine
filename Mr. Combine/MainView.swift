//
//  SwiftUIView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("Fututre") {
                    FutureView()
                }
                NavigationLink("PassthroughSubject") {
                    PassthroughSubjectView()
                }
                NavigationLink("Timer") {
                    TimerView()
                }
                NavigationLink("DataTaskPublisher") {
                    DataTaskPublisherView()
                }
                NavigationLink("DataTaskPublisherForImages") {
                    DataTaskPublisherImage()
                }
                NavigationLink("Contains(where:)") {
                    ContainsWhereView()
                }
                NavigationLink("TryContains(where:)") {
                    TryContainsView()
                }
                NavigationLink("Collect") {
                    CollectView()
                }
                NavigationLink("CollectBy: ") {
                    CollectBy()
                }
                NavigationLink("CollectByTime: ") {
                    CollectByView()
                }
                NavigationLink("IgnoreOutput") {
                    IgnoreOutput()
                }
                NavigationLink("Reduce") {
                    ReduceView()
                }
                NavigationLink("First(where: )") {
                    FirstWhereView()
                }
                NavigationLink("Output(at: )") {
                    OutputAtView()
                }
                NavigationLink("Output(In: )") {
                    OutputInView()
                }
                NavigationLink("ReceiveOn") {
                    ReceiveOnView()
                }
                NavigationLink("SubscribeOn") {
                    SubscribeOnView()
                }
                NavigationLink("Assign(to: )") {
                    AssigntToView()
                }
                NavigationLink("Sink") {
                    SinkReciveValue()
                }
                NavigationLink("Any Publisher") {
                    AnyPublisherView()
                }
                NavigationLink("CombineLatest") {
                    CombineLatestView()
                }
                NavigationLink("FlatMap") {
                    FlatMapView()
                }
                NavigationLink("MergeView") {
                    MergeView()
                }
                NavigationLink("SwitchToLatest") {
                    SwitchToLatestView()
                }
                NavigationLink("Catch") {
                    CatchView()
                }
                NavigationLink("Try Catch") {
                    TryCatchView()
                }
                NavigationLink("Breakpoint") {
                    BreakpointView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
