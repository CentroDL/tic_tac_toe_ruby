class Keyboard

  attr_reader :old_state

  def initialize
    @old_state = `stty -g`
  end

  def listen
    begin
    system "stty raw -echo"
    input_char = STDIN.getc.chr
    if(input_char =="\e")
      extra_thread = Thread.new{
        input_char += STDIN.getc.chr
        input_char += STDIN.getc.chr
      }
      extra_thread.join(0.00001)
      extra_thread.kill
    end

    rescue => ex
      puts "#{ex.class}: #{ex.message}"
      puts ex.backtrace
    ensure
      system "stty #{old_state}"
    end

    return input_char
  end


end
