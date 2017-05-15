//
//  TimeLabel.swift
//  Time_Test
//
//  Created by 伯驹 黄 on 16/2/2.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class TimeLabel: UILabel {
    fileprivate let timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default))
    
    fileprivate var endTime: String!
    fileprivate var isTiming = true
    
    convenience init (frame: CGRect, endTime: String, textColor: UIColor = UIColor.black, bgColor: UIColor = UIColor.white) {
        self.init()
        self.frame = frame
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.endTime = endTime
    }
    
    private func gcd(_ timeCount: Int) {
        var timeCount = timeCount
        timer.setTimer(start: DispatchWallTime(time: nil), interval: NSEC_PER_SEC, leeway: 0)
        timer.setEventHandler(handler: { () -> Void in
            if timeCount <= 0 {
                self.timer.cancel()
                DispatchQueue.main.async(execute: { () -> Void in
                    self.timeformatFromSeconds(timeCount)
                })
            } else {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.timeformatFromSeconds(timeCount)
                })
                timeCount -= 1
            }
        })
        timer.resume()
    }
    
    fileprivate func timeformatFromSeconds(_ seconds: Int) {
        if seconds > 0 {
            var text = "剩余:"
            if (seconds / 86400) >= 1 {
                text += "\(seconds / 86400)天"
                if (seconds % 86400 / 3600) >= 1 {
                    text += "\(seconds % 86400 / 3600)小时"
                    if (seconds % 3600 / 60) >= 1 {
                        text += "\(seconds % 3600 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                } else {
                    text += "00小时"
                    if (seconds % 86400 / 60) >= 1 {
                        text += "\(seconds % 86400 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                }
            } else {
                text += "0天"
                if (seconds / 3600) >= 1 {
                    text += "\(seconds / 3600)小时"
                    if (Int(seconds) % 3600 / 60) >= 1 {
                        text += "\(seconds % 3600 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                } else {
                    text += "00小时"
                    if (seconds / 60) >= 1 {
                        text += "\(seconds / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                }
            }
            self.text = text
        } else {
            self.text = "抢购已结束"
        }
        self.sizeToFit()
    }
    
    func start() {
        if isTiming {
            isTiming = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let endTime = dateFormatter.date(from: self.endTime)
            let seconds = Int((endTime?.timeIntervalSinceNow)!) + 1
            gcd(seconds)
        }
    }
    
    func stop() {
        isTiming = true
        timer.suspend()
    }
}
