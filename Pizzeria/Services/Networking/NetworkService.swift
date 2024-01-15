//
//  NetworkService.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

protocol AppNetworkService {
    func downloadMenu(category: String, completion: @escaping (Result<[MenuItem], NetworkError>) -> ())
    func downloadImageData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkService: AppNetworkService {
    private enum API {
        static let key = "5abbbc3716094d93b1ca6e7cbff63ea1"
        static let key2 = "bc9b38fb6442421a943eeef365c9dab4"
    }

    private let searchEndpoint = "https://api.spoonacular.com/"

    func downloadMenu(category: String, completion: @escaping (Result<[MenuItem], NetworkError>) -> Void) {
        let url = URL(string: searchEndpoint + "food/menuItems/search?query=" + "\(category)" + "&number=10&apiKey=" + API.key2)
        fetchData(from: url) { [weak self] dataFetchingResult in
            guard let self else { return }

            switch dataFetchingResult {
            case let .success(data):
                parseProductItems(from: data) { decodingResult in
                    DispatchQueue.main.async {
                        switch decodingResult {
                        case let .success(menuItems):
                            completion(.success(menuItems))
                        case let .failure(error):
                            completion(.failure(error))
                        }
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    func downloadImageData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        fetchData(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(imageData):
                    completion(.success(imageData))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    private func fetchData(from url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.handleNetworkError(error, completion)
            } else {
                self.handleHTTPResponse(response, data, completion)
            }
        }
        dataTask.resume()
    }

    private func handleNetworkError(_ error: Error, _ completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let error = error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            completion(.failure(.requestFailed))
        }
    }

    private func handleHTTPResponse(_ response: URLResponse?, _ data: Data?, _ completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.noServerResponse))
            return
        }

        switch httpResponse.statusCode {
        case 200:
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.noDataInServerResponse))
            }
        case 403:
            completion(.failure(.forbidden403))
        default:
            completion(.failure(.badResponse(statusCode: httpResponse.statusCode)))
        }
    }

    private func parseProductItems(from data: Data, completion: @escaping (Result<[MenuItem], NetworkError>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let menu = try decoder.decode(Menu.self, from: data)
            completion(.success(menu.menuItems!))
        } catch {
            completion(.failure(NetworkError.decodingFailed))
        }
    }
}

