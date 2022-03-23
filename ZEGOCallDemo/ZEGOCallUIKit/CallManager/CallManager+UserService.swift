//
//  CallManager+UserService.swift
//  ZEGOCallDemo
//
//  Created by zego on 2022/3/19.
//

import UIKit
import ZegoExpressEngine

extension CallManager: UserServiceDelegate {
    func onNetworkQuality(_ userID: String, upstreamQuality: ZegoStreamQualityLevel) {
        if userID == localUserID {
            if let currentCallVC = currentCallVC {
                currentCallVC.callQualityChange(setNetWorkQuality(upstreamQuality: upstreamQuality), userID: userID)
            }
        }
    }
    
    private func setNetWorkQuality(upstreamQuality: ZegoStreamQualityLevel) -> NetWorkStatus {
        if upstreamQuality == .excellent || upstreamQuality == .good {
            return .good
        } else if upstreamQuality == .medium {
            return.middle
        } else if upstreamQuality == .unknown {
            return .unknow
        } else {
            return .low
        }
    }
    
    func onReceiveUserError(_ error: UserError) {
        
    }
    
    func onUserInfoUpdate(_ userInfo: UserInfo) {
        if userInfo.userID != localUserID {
            otherUserRoomInfo = userInfo
        }
        guard let currentCallVC = currentCallVC else { return }
        currentCallVC.userRoomInfoUpdate(userInfo)
        
    }
    
    func onReceiveCallingUserDisconnected(_ userInfo: UserInfo) {
        delegate?.onReceiveCallingUserDisconnected(userInfo)
    }
    
}
