//
//  API.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import Alamofire

class API {

    public let baseUrl = "https://api.themoviedb.org/3/"
    
    

    //API end points
    private let getMovieList = "movie/now_playing?"
    enum type {
        case getMovieList
        
    }

    func getAPIUrl(APItype: type) -> String {
        var apiUrl = baseUrl

        switch APItype {
            
        case .getMovieList:
            apiUrl.append(getMovieList)
            
        }

        return apiUrl
    }

    // API CALLS
    
    
    

    private func alamofireCall(url: String, params: Parameters?, headers: HTTPHeaders, APIMethod: HTTPMethod, urlEncoding: Bool, CompletionHandler: @escaping ((DataResponse<Any>), Bool) -> ()) {
        Alamofire.request(url, method: APIMethod, parameters: params, headers: headers).responseJSON
        { response in
            
            CompletionHandler(response, response.response?.statusCode == 200 ? true : false)
            return
        }
    }
    
    
    func callAPI(params: Parameters = [:], APItype: type, APIMethod: HTTPMethod = .get, withUrlEncoding: Bool = false, shouldPresentPendingScreen: Bool = true, CompletionHandler: @escaping (String, Bool) -> ()) {
        var apiParameters: Parameters? = params

        if APIMethod == .get {
            apiParameters = nil
        }

        var apiUrl = getAPIUrl(APItype: APItype)

        apiUrl.append("api_key=\(String(describing: getAuthKey()))&page=1")
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "OS" : "ios"
        ]

        
        Logger.print("\nURL:\(apiUrl)\nPARAMS: \(params)\nHEADERS: \(headers)\n METHOD: \(APIMethod)\n")
        
        

        alamofireCall(url: apiUrl, params: apiParameters, headers: headers, APIMethod: APIMethod, urlEncoding: withUrlEncoding) { (response, status) in

            //IF DATA IS AVAILABLE

            switch response.result {
            case .success:
                switch APItype {
                case .getMovieList:
                    if let json = response.result.value as? [String : AnyObject] {
                        guard let data = self.jsonToData(json: json) else { return }
                        Movies.movieList.nowShowing = try! JSONDecoder().decode(NowShowingModel.self, from: data)
                        CompletionHandler("", true)
                        return
                    }
                    CompletionHandler("", false)
                    return
                }
            case .failure:
                Logger.print(response.result)
            }
        }
    }
    
    func getAuthKey() -> String {
        guard let infoPlistDict = Bundle.main.infoDictionary
        else {
            return ""
        }
        if let movieDB = infoPlistDict["movieDB"] as? [String : String] {
             return movieDB["auth_key"] ?? ""
        }
        return ""
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}
