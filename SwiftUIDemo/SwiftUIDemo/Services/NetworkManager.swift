//
//  NetworkManager.swift
//  iOSDemo
//
//  Created by Apple on 29/06/22.
//

import Foundation

enum MyError:Error {
    case Undefined
    case BadURL
    case NoData(message:String)
    case DecodingError
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Undefined: return ""
        case .BadURL: return "Bad URL"
        case .NoData(let msg): return "No Data \"" + msg + "\""
        case .DecodingError: return "Decoding Error"
        }
    }
}


class NetworkManager{
    private var apiHandler:APIHandlerDelegate
    private var responseHandler:ResponseHandlerDelegate = ResponseHandler()
    
    init(apiH:APIHandlerDelegate = APIHandler() ) {
        self.apiHandler = apiH
        //self.responseHandler = respH
    }
    func fetchRequest<T:Codable>(urlReq:URLRequest, modelType:T.Type, completion:@escaping (Result<T,MyError>)->Void){
      
        apiHandler.fetchData(urlReq: urlReq) { (result) in
            switch result{
            case .failure(let error) :
                completion(.failure(error))
            case .success(let data) :
                self.responseHandler.fetchModel(data: data, type: modelType, completion: { (resultModel) in
                    switch resultModel{
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let model):
                        completion(.success(model))
                    }
                })
            }
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(urlReq:URLRequest, completion:@escaping (Result<Data, MyError>)->Void)
}
protocol ResponseHandlerDelegate {
    func fetchModel<T:Codable>(data:Data,type:T.Type, completion:@escaping (Result<T, MyError>)->Void)
}

class APIHandler:APIHandlerDelegate{
    func fetchData(urlReq:URLRequest, completion:@escaping (Result<Data, MyError>)->Void){
        let session = URLSession.shared
        session.dataTask(with: urlReq) { (data, response, error) in
            guard let data = data, error == nil else{
                completion(.failure(.NoData(message: error?.localizedDescription ?? "")))
                return
            }
            completion(.success(data))
                        
        }.resume()
    }
}
class ResponseHandler:ResponseHandlerDelegate{
    func fetchModel<T:Codable>(data:Data,type:T.Type, completion:(Result<T, MyError>)->Void){

        if let model = try? JSONDecoder().decode(type.self, from: data){
            completion(.success(model))
        }else{
            completion(.failure(.DecodingError))
        }

//        if let path = Bundle.main.path(forResource: "data", ofType: "json"){
//            do {
//                let contents = try String(contentsOfFile: path)
//                let d2 = Data(contents.utf8)
//                do {
//                    if let model = try? JSONDecoder().decode(type.self, from: d2){
//                        completion(.success(model))
//                    }else{
//                        completion(.failure(.DecodingError))
//                    }
//
//                } catch let er {
//                    print(er.localizedDescription)
//                }
//
//            } catch let err{
//                // contents could not be loaded
//                print(err.localizedDescription)
//            }
//        } else {
//            // example.txt not found!
//            print("invalid path")
//        }
 
    }
}
