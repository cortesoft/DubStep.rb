class DubStep
  def initialize(bpm = 60, bass = 'boom', snare = 'tick')
    @bpm = bpm
    @bass = bass
    @snare = snare
    @threads = []
  end
  
  def play
    @threads << Thread.new {
      while true
        t = Time.now
        `say #{@bass}`
        sleep_beat(2, t)
      end
    }
    @threads << Thread.new {
      while true
        sleep_beat(1)
        t = Time.now
        `say #{@snare}`
        sleep_beat(2, t)
        t = Time.now
        `say #{@snare}`
        sleep_beat(1, t)
      end
    }
  end
  
  def sleep_beat(beats, t = Time.now)
    sleep(((60.0 / @bpm) * beats) - (Time.now - t))
  end

  def kill
    @threads.each {|t| t.kill}
  end
end