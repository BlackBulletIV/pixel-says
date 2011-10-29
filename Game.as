package
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  
  public class Game extends Engine
  {
    public function Game()
    {
      super(1, 1);
      FP.world = new Black;
      FP.screen.scaleX = FP.screen.scaleY = 400;
      
      Input.define("start", Key.ENTER);
      Input.define("red", Key.DIGIT_1, Key.R);
      Input.define("green", Key.DIGIT_2, Key.G);
      Input.define("yellow", Key.DIGIT_3, Key.Y);
      Input.define("blue", Key.DIGIT_4, Key.B);
    }
  }
}
