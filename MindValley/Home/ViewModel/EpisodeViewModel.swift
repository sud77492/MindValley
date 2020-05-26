//
//  EpisodeViewModel.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 19/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class EpisodeViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let episodes : PublishSubject<[Episode]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        APIManager.requestData(url: "https://pastebin.com/raw/z5AExTtw", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let episodes = returnJson["data"]["media"].arrayValue.compactMap {return Episode(data: try! $0.rawData())}
                self.episodes.onNext(episodes)
                //print(episodes)
            case .failure(let failure):
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
}

