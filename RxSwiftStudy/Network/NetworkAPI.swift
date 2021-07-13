//
//  NetworkAPI.swift
//  Build
//
//  Created by Alan on 2020/5/6.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

@_exported import Moya
@_exported import RxCocoa
@_exported import RxSwift
@_exported import NSObject_Rx


public struct MoyaMapperPlugin:PluginType{
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        let url = target.baseURL.absoluteString + target.path
//        print("当前url\(url)")
//        print("当前task:",target.task)
//        print("当前header:",target.headers ?? "")
//        switch result {
//        case .success(let response):
//            if let json = try? response.mapJSON() as? [String:Any]{
//                print(json)
//            }
//        default:
//            break
//        }
    }
}

// MARK: - 请求添加默认值
extension TargetType {
    var baseURL: URL {
        return URL(string: BaseUrl)!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    static var token: String {
        var cryptStr = "userid=\(UserId)&platform=3&dev=\(DeviceInfo)"
        cryptStr = cryptStr.encrypt()
        return cryptStr
    }
    
    var headers: [String : String]? {
        return ["Token-Cninct":Self.token]
    }
}
let disposed = DisposeBag()


let EndPointClouser = {(target:TargetType) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    
    let endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
        
    )

    return endpoint
}


class NetworkAPI<Target:TargetType>: NSObject {
    
    /// 请求构造器
    ///
    /// - Parameter target: 目标枚举
    /// - Returns: 构造器
    static func provider() -> MoyaProvider<Target> {
        
        
        let provider = MoyaProvider<Target>(endpointClosure: EndPointClouser,plugins: [MoyaMapperPlugin()])
        
        return provider
    }
}



//数据映射错误
public enum RxObjectMapperError: Error {
    case NoResponse
    case RequestFailed
    case JSONToModelFailed
    case FormatError
}

extension Observable {
    //将JSON数据转化成对象
    func mapObject<T:HandyJSON>(type:T.Type) -> Observable<T>{
        return map { response in
            
            guard let response = response as? Moya.Response
            else {
                throw RxObjectMapperError.NoResponse
            }
            guard ((200...209) ~= response.statusCode) else {
                throw RxObjectMapperError.RequestFailed
            }
            
            let json = try response.mapJSON() as! [String : Any]
            
            
            if let state = json["state"] as? Int{
                switch state {
                case 0:
                    //成功
                    if let ext = json["ext"] as? [String: Any] {
                        
                        guard let model = JSONDeserializer<T>.deserializeFrom(dict: ext) else{
                            throw RxObjectMapperError.JSONToModelFailed
                        }
                        return model
                    }
                    break
                case 5:
                    //需重新登录
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        //                    AppInitConfig.reloadLogin()
                    }
                    break
                default:
                    
                    break
                }
                
            }
            
            throw RxObjectMapperError.FormatError
        }
    }
    
    
    //将JSON数组转化成对象
    func mapArray<T:HandyJSON>(type:T.Type) -> Observable<[T]>{
        
        return map { response in
            
            guard let response = response as? Moya.Response
            else {
                
                throw RxObjectMapperError.NoResponse
            }
            
            guard ((200...209) ~= response.statusCode) else {
                throw RxObjectMapperError.RequestFailed
            }
            
            let json = try response.mapJSON() as! [String : Any]
            
            
            if let state = json["state"] as? Int{
                switch state {
                case 0:
                    //成功
                    if let ext = json["ext"] as? [String: Any] {
                        let result = ext["result"] as? [Any]
                        guard let array = JSONDeserializer<T>.deserializeModelArrayFrom(array: result) as? [T] else{
                            throw RxObjectMapperError.JSONToModelFailed
                        }
                        return array
                    }
                    break
                case 5:
                    //需重新登录
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        //                    AppInitConfig.reloadLogin()
                    }
                    break
                default:
                    
                    break
                }
                
            }
            
            throw RxObjectMapperError.FormatError
        }
    }
    
}







extension BehaviorRelay where Element:RangeReplaceableCollection{
    func append (_ subElement:Element.Element){
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }
    
    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }
}
