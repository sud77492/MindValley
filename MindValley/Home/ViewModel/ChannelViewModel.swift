//
//  ChannelViewModel.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 24/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ChannelViewModel {
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let channels : PublishSubject<[Channel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        APIManager.requestData(url: "https://pastebin.com/raw/Xt12uVhM", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            print(result)
            switch result {
            case .success(let returnJson) :
                let channels = returnJson["data"]["channels"].arrayValue.compactMap {return Channel(data: try! $0.rawData())}
                self.channels.onNext(channels)
                print(channels)
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



