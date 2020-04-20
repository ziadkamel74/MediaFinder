//
//  APIManager.swift
//  RegistrationApp
//
//  Created by Ziad on 3/28/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    class func loadMovies(artistName: String, media: Int, completion: @escaping (_ error: Error?, _ receivedMedia: [ReceivedMedia]?) -> Void) {
        
        AF.request(Urls.base, method: HTTPMethod.get, parameters: [apiKeys.term : artistName, apiKeys.media : apiMedia.typeIndex[media] ?? ""], encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didnt get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResults = try decoder.decode(Results.self, from: data)
                let receivedMediaArr = apiResults.results
                completion(nil, receivedMediaArr)
            }
            catch let error {
                print(error)
            }
        }
    }
}
