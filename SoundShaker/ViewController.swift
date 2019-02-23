//
//  ViewController.swift
//  SoundShaker
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var currentIndex:Int = 0
    var songs:[String] = ["Heart","DanBern","TheCamp","TheDevil","TonyFur"]
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var currentPlaying: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Define Right Swipe Action Variable ------->
        let swipeRight = UISwipeGestureRecognizer(target: self, action:  #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        //<-------End Right Swiper Action Variable
        
        //Define Lefrt Swipe Action Variable--->
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.left

        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func swiped(gesture:UIGestureRecognizer){
       
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
        
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right{
                
                if currentIndex == songs.count-1 {
               
                }
                
                else{
                    self.currentIndex += 1
                }
            }
            else{
                if currentIndex >= 1{
                    self.currentIndex -= 1
                }
                else{
                    currentIndex = 0
                }
            }
        
        }
        playSong()
    }
    
    func getRandomSong() -> String{
         currentIndex = Int.random(in: 0 ..< self.songs.count)
        return songs[currentIndex]
    }
    
    func playSong(){
        let audioPath = Bundle.main.path(forResource: songs[currentIndex], ofType: "mp3")
        do {audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))}
        catch{
            print("error")
        }
        currentPlaying.text = "\(currentIndex+1). \(songs[currentIndex])"
        audioPlayer.play()
        
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            currentIndex = Int.random(in: 0..<songs.count)
            let audioPath = Bundle.main.path(forResource: songs[currentIndex], ofType: "mp3")
            do {audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))}
            catch{
                print("error")
            }
            currentPlaying.text = "\(currentIndex+1). \(songs[currentIndex])"
            audioPlayer.play()
        }
    }

}

