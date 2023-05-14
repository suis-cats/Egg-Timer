import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft":3*60 , "Medium":5*60, "Hard":7*60]
    //timerを宣言
    var timer = Timer()
    @IBOutlet weak var progressBar: UIProgressView!
    var totalTime = 0
    var secondsPassed = 0
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //musicをリセット
        if player != nil && player.isPlaying {
                   player.stop()
        }
        //再生
        playSound(soundName: "3mincooking")
        
        
        
        //押されたボタンのタイトルを読み込む
        let hardness = sender.currentTitle!
        print(eggTimes[hardness]!)
        
        //タイマーを無効化
        timer.invalidate()
        //progressバーを0にする
        progressBar.progress = 0.0
        secondsPassed = 0
        //上の文字をボタンのラベルの文字にする
        self.topText.text = hardness

        //secondsRemaingに秒数を代入
        totalTime = eggTimes[hardness]!
        
        //一定時間（1秒）経過した後にupdateTimerを実行する関数
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(updateTimer), userInfo: nil , repeats: true)
    }
    
    @IBOutlet weak var topText: UILabel!
    
    //上のtimerによって1秒おきに実行される関数
    @objc private func updateTimer() {
      // 30秒後に実行したい処理を記述
        if secondsPassed < totalTime {
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            print(secondsPassed)
            progressBar.progress = percentageProgress
          
            secondsPassed += 1
        } else {
            timer.invalidate()
            self.topText.text = "完了"
            player.stop()
            // サウンドを再生する
            playSound(soundName: "alarm_sound")
            
        }
    }
    
    
    func playSound(soundName: String) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("error")
            }
        }
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        //音を停止
        if player != nil && player.isPlaying {
                   player.stop()
        }
        //タイマーを無効化
        timer.invalidate()
    }
    
    
    
    
    
    
    
    
    
   


}
