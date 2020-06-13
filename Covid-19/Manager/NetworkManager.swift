import UIKit
import Alamofire
import SVProgressHUD

class NetworkManager: NSObject {
 
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    func fetchCovidData(urlEndPoint: String, params: [String:Any]?, onSuccess: @escaping ((Data)->()), onFailure: @escaping((String)->())){
        
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        
        var requestUrl = "\(baseUrl)\(urlEndPoint)"
        
        if params != nil{
            requestUrl = "\(requestUrl)?\(convertDictionaryToQuery(params: params!))"
        }
        
        AF.request(requestUrl, method: .get, parameters: params).responseData { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            switch response.result{
            case .success(let data):
                onSuccess(data)
                break
            case .failure(let requestError):
                onFailure(requestError.errorDescription ?? "Error in request")
                break
            }
        }
    }
    
    func convertDictionaryToQuery(params:[String:Any]) -> String{
        var output: String = ""
        for (key,value) in params {
            output +=  "\(key)=\(value)&"
        }
        return output
    }
}
