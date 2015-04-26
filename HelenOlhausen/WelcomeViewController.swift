//
//  WelcomeViewController.swift
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/26/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

import UIKit
import AVFoundation

public class WelcomeViewController: UIViewController {
    
    private var player: AVAudioPlayer!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        self.playBackAudio()
    }
    
    override public func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated)
        self.player.stop()
    }
    

    private func playBackAudio() -> Void {
        let url:NSURL! = NSBundle.mainBundle().URLForResource("TryHel", withExtension:"mp3")
        self.player = AVAudioPlayer(contentsOfURL:url, error:nil)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error:nil)
        AVAudioSession.sharedInstance().setActive(true, error:nil)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.player.prepareToPlay()
        self.player.play()
    }

}