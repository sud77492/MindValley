//
//  CategoryViewModel.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 22/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoryViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let categories : PublishSubject<[Category]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        APIManager.requestData(url: "https://pastebin.com/raw/A0CgArX3", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let categories = returnJson["data"]["categories"].arrayValue.compactMap {return Category(data: try! $0.rawData())}
                self.categories.onNext(categories)
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


