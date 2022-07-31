//
//  AGLiveViewModel.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

enum AGLiveViewModelRoute {
    case initial
    case back
    case error
    case activity(loading: Bool)
}

protocol AGLiveViewModelInput {
    func triggerGetAllLiveEvents()
}

protocol AGLiveViewModelOutput {
    var eventsData: Dynamic<AGLiveEventsModelData> { get set }
    var route: Dynamic<AGLiveViewModelRoute> { get set }
}

protocol AGLiveViewModel: AGLiveViewModelInput, AGLiveViewModelOutput {
    
}

final class DefaultAGLiveViewModel: AGLiveViewModel {
    
    var eventsData: Dynamic<AGLiveEventsModelData> = Dynamic(AGLiveEventsModelData())
    var route: Dynamic<AGLiveViewModelRoute> = Dynamic(.initial)
    
    var liveEventsUseCase: LiveEventsUseCase
    
    init(liveEventsUseCase: LiveEventsUseCase) {
        self.liveEventsUseCase = liveEventsUseCase
    }
}

extension AGLiveViewModel{
    
    func triggerGetAllLiveEvents() {
        route.value = .activity(loading: true)
        AGAPIGateway.door().getLiveEvents { (events, error) in
            if error != nil{
                self.route.value = .error
            }else{
                var liveEvents = AGLiveEventsModelData()
                liveEvents.liveEvents = events
                self.eventsData.value = liveEvents
                
                self.route.value = .activity(loading: false)
            }
        }
        
    }
}
