//
//  ColorsAPIService.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import Foundation

struct ColorsAPIService {
    func getColorData(red: Int, green: Int, blue: Int, completion: @escaping (ColorData) -> ()) {
        guard let url = URL(string: "https://www.thecolorapi.com/id?rgb=rgb(\(red),\(green),\(blue))") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.global(qos: .userInteractive).async {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try! jsonDecoder.decode(ColorData.self, from: data)
                
                
                completion(decodedData)
            }
        }.resume()
        
    }
}
