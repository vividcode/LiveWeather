//
//  CustomURLRequest.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/31/20.
//

import Foundation

struct RequestFactory {
    private static var requestDictionary: [String: URLRequest] = [:]

    /**Creates requests for weather API. Also caches them based on URL strings.*/
	static func makeGETRequest(urlString: String) -> URLRequest? {
		guard let url = URL(string: urlString)
		else {
			return nil
		}

		var rq = URLRequest(url: url)

		if let request = RequestFactory.requestDictionary[url.absoluteString] {
			return request
		}

        rq.httpMethod = "GET"
        rq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        rq.addValue("application/json", forHTTPHeaderField: "Accept")
        rq.timeoutInterval = APIFetchOptions.apiTimeout

        RequestFactory.requestDictionary[url.absoluteString] = rq

        return rq
    }
}
