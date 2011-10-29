package
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  
  public class Black extends World
  {
    public static var id:Black;
    
    public function Black()
    {
      id = this;
    }
    
    override public function begin():void
    {
      FP.screen.color = 0x111111;
    }
    
    override public function update():void
    {
      if (Input.pressed("start")) FP.world = new GameWorld;
    }
  }
}
