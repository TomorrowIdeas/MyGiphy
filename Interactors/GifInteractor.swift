//
//  GifInteractor.swift
//  MyGiphy
//
//  Created by Lahari on 06/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation

class GifInteractor {
    func fetchGifs(_ endpoint: Endpoint, completionHandler: @escaping ((GraphicInterfaceFormat?, Error?) -> Void)) {
        guard let url = endpoint.url else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completionHandler(nil, error)
            }

            if let data = data {
                guard let result = try? JSONDecoder().decode(GraphicInterfaceFormat.self, from: data) else { return }
                completionHandler(result, nil)
            }
        }

        task.resume()
    }
}
