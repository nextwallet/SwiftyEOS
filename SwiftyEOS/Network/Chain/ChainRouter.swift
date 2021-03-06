//
//  ChainRouter.swift
//  SwiftyEOS
//
//  Created by croath on 2018/5/4.
//  Copyright © 2018 ProChain. All rights reserved.
//

import Foundation

enum ChainEndpoint {
    case GetInfo()
    case GetBlock(blockNumberOrId: AnyObject)
}

class ChainRouter: BaseRouter {
    var endpoint: ChainEndpoint
    init(endpoint: ChainEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod {
        switch endpoint {
        case .GetInfo: return .get
        case .GetBlock: return .post
        }
    }
    
    override var path: String {
        switch endpoint {
        case .GetInfo: return "/chain/get_info"
        case .GetBlock: return "/chain/get_block"
        }
    }
    
    override var parameters: QueryParams {
        switch endpoint {
        case .GetInfo(): return [:]
        case .GetBlock(_): return [:]
        }
    }
    
    override var body: Data? {
        switch endpoint {
        case .GetInfo(): return nil
        case .GetBlock(let blockNumberOrId):
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(["block_num_or_id": "\(blockNumberOrId)"])
            return jsonData
        }
    }
}
