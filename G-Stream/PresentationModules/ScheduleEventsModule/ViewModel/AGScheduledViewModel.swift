//
//  AGScheduledViewModel.swift
//  G-Stream
//
//  Created by Wykee Njenga on 8/3/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

enum AGScheduledViewModelRoute {
    case initial
    case back
    case error
    case activity(loading: Bool)
}

protocol AGScheduledViewModelInput {
    func getScheduledEvents()
}

protocol AGScheduledViewModelOutput {
    var eventsData: Dynamic<AGScheduledEventsModelData> { get set }
    var route: Dynamic<AGLiveViewModelRoute> { get set }
}

protocol AGScheduledViewModel: AGScheduledViewModelInput, AGScheduledViewModelOutput {
    
}

final class DefaultAGScheduledViewModel: AGScheduledViewModel {
    
    var eventsData: Dynamic<AGScheduledEventsModelData> = Dynamic(AGScheduledEventsModelData())
    var route: Dynamic<AGLiveViewModelRoute> = Dynamic(.initial)

    
    init() {
        
    }
}

extension AGScheduledViewModel{
    
    func getScheduledEvents() {
        route.value = .activity(loading: true)
        AGAPIGateway.door().getScheduledEvents { (events, error) in
            if error != nil{
                self.route.value = .error
            }else{
                var liveEvents = AGScheduledEventsModelData()
                liveEvents.scheduledEvents = events
                self.eventsData.value = liveEvents
                
                self.route.value = .activity(loading: false)
            }
        }
        
    }
}

