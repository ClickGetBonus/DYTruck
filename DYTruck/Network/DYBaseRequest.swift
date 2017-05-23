//
//  DYBaseRequest.swift
//  DYTruck
//
//  Created by Lan on 2017/5/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork
import SVProgressHUD

class DYBaseRequest: YTKRequest {
    
    var isSilent: Bool = false
    var isShowHud: Bool = true
    
    
    override func baseUrl() -> String {
        return DYBaseURL
    }
    
    override func requestTimeoutInterval() -> TimeInterval {
        return DYRequestTimeoutInterval
    }
    
    override func requestArgument() -> Any? {
        let param: [String : Any] = [:]
        return param
    }
    
    override func start() {
        if self.isShowHud {
            SVProgressHUD.show()
        }
        
        super.start()
    }
    
    override func statusCodeValidator() -> Bool {
        return self.responseStatusCode == 1 || self.responseStatusCode == 200
    }
    
    override func requestSerializerType() -> YTKRequestSerializerType {
        return .HTTP
    }
    
    var headerDic: [String: Any] = [:]
    func getHeaderParamDic() -> [String: Any] {
        if headerDic.isEmpty {
            headerDic["platForm"] = 2
            headerDic["appVersion"] = Bundle.main.infoDictionary?["CFBundleVersion"]
            headerDic["systemVersion"] = UIDevice.systemVersion()
            headerDic["phoneMark"] = UIDevice.current.machineModelName
        }
        
        return headerDic
    }
    
    
    //MARK: - Filter
    override func requestCompleteFilter() {
        super.requestCompleteFilter()
        
        
        let url = YTKNetworkConfig.shared().baseUrl + self.requestUrl()
        DLog("请求URL = \(url)")
        var requestMethod: String
        switch self.requestMethod() {
        case .GET:
            requestMethod = "GET"
        case .POST:
            requestMethod = "POST"
        case .HEAD:
            requestMethod = "HEAD"
        case .DELETE:
            requestMethod = "DELETE"
        case .PUT:
            requestMethod = "PUT"
        case .PATCH:
            requestMethod = "PATCH"
        }
        DLog("请求方式 = \(requestMethod)")
        DLog("请求参数 = \(self.requestArgument() ?? "")")
        
        
        let bean = DYResponse.parse(data: self.responseString!)!
        if self.isDataFromCache() {
            DLog("缓存数据====\(self.responseString!)")
        } else {
            DLog("statusCode = \(self.responseStatusCode) , \(url)\n 返回数据 = \(self.responseString ?? "")")
        }
        
        if bean.isOperateSuccess() {
            DLog("返回成功")
            
            if isShowHud {
                SVProgressHUD.dismiss()
            }
            
        } else {
            
            if !self.isSilent {
                SVProgressHUD.showError(withStatus: bean.message)
                SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            }
            
            DLog("请求操作执行失败")
            if self.failureCompletionBlock != nil {
                self.failureCompletionBlock!(self)
            }
            self.stop()
            if !self.isCancelled {
                self.successCompletionBlock = nil
                self.failureCompletionBlock = nil
            }
        }
        
    }
    
    override func requestFailedFilter() {
        super.requestFailedFilter()
        
        var url = YTKNetworkConfig.shared().baseUrl + self.requestUrl()
        DLog("请求URL = \(url)")
        var requestMethod: String
        switch self.requestMethod() {
        case .GET:
            requestMethod = "GET"
        case .POST:
            requestMethod = "POST"
        case .HEAD:
            requestMethod = "HEAD"
        case .DELETE:
            requestMethod = "DELETE"
        case .PUT:
            requestMethod = "PUT"
        case .PATCH:
            requestMethod = "PATCH"
        }
        DLog("请求方式 = \(requestMethod)")
        DLog("请求参数 = \(self.requestArgument() ?? "")")
        
        if self.useCDN() {
            url = YTKNetworkConfig.shared().cdnUrl + self.requestUrl()
        }
        DLog("statusCode = \(self.responseStatusCode) , \(url)\n 返回数据 = \(self.responseString ?? "")")
        
        if isShowHud {
            SVProgressHUD.dismiss()
            
            if self.isSilent {
                SVProgressHUD.show(withStatus: "网络不给力,请稍后再试!")
                SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            }
        }
    }
}
