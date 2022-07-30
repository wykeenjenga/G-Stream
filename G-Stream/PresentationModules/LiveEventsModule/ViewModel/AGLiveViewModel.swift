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
    case openProfileDetail(userId: String)
    case activity(loading: Bool)
    case showErrorAlert
}

protocol AGLiveViewModelInput {
    func triggerGetAllComment()
    func triggerAddFeedComment(text: String)
    func clearPreviousHome()
    func didSelect(index: Int)
}

protocol AGLiveViewModelOutput {
//    var previousHomees: Dynamic<[String]> { get set }
//    var feedList: Dynamic<[Int]> { get set }
//    var commentId: Dynamic<String> {get set}
//    var userIdentifier: Dynamic<String> {get set}
//    var feedIdentifier: Dynamic<String> {get set}
}

protocol AGLiveViewModel: AGLiveViewModelInput, AGLiveViewModelOutput {
    
}

final class DefaultAGLiveViewModel: AGLiveViewModel {
    
//    var feedId: Dynamic<String>
//    var commentId: Dynamic<String> = Dynamic("")
//    var userIdentifier: Dynamic<String> = Dynamic("")
//    var feedIdentifier: Dynamic<String> = Dynamic("")
//    var feedList: Dynamic<[Int]> = Dynamic([])
    
    private var liveEventsUseCase: liv
    
    init(liveEventsUsecase: AddFeedLikeUseCase) {
        self.profile = Dynamic(profile)
    }
    
}

extension AGLiveViewModel {
    
    func triggerGetAllComment() {
    }
    
    //add comment
    func triggerAddFeedComment(text: String) {
    }


    func clearPreviousHome() {
        
    }
    
    func didSelect(index: Int) {
        
    }
    
}
