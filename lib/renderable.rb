module Renderable
  def clear_screen
    system "clear" or system "cls"
  end
end
