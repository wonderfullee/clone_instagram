//
//  KeyChainService.swift
//  instagram
//
//  Created by zhihao li on 3/26/19.
//  Copyright © 2019 zhihao li. All rights reserved.
//

import Foundation
import KeychainSwift

class KeyChainService{
    var _keyChain = KeychainSwift()
    var keyChain: KeychainSwift{
        get{
            return _keyChain
        }
        set{
            _keyChain = newValue
        }
    }
}

