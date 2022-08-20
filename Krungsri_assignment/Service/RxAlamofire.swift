//
//  RxAlamofire.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Alamofire
import Foundation
import RxSwift
import SwiftyJSON

protocol Alamofire {
    func getRequest(with Url: String, parameter: [String : Any]?, method: HTTPMethod) -> Observable<JSON>
}

class RxAlamofire: Alamofire {
    func getRequest(with Url: String, parameter: [String : Any]? = nil, method: HTTPMethod) -> Observable<JSON> {
       return Observable.create { observer in
           AF.request(Url, method: method, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { response in
               switch response.result {
                   
               case .success(let value):
                   let response = JSON(value)
                   observer.onNext(response)
                   
               case .failure(let error):
                   observer.onError(error)
               }
           }
           return Disposables.create()
       }
   }
}
