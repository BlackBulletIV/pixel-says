package
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  
  public class GameWorld extends World
  {
    [Embed(source = "sound/red.mp3")]
    public static const RED_SFX:Class;

    [Embed(source = "sound/green.mp3")]
    public static const GREEN_SFX:Class;
    
    [Embed(source = "sound/yellow.mp3")]
    public static const YELLOW_SFX:Class;
    
    [Embed(source = "sound/blue.mp3")]
    public static const BLUE_SFX:Class;
    
    [Embed(source = "sound/game-over.mp3")]
    public static const GAME_OVER_SFX:Class;
    
    public static const COLOR_TIME:Number = 0.5;
    public static const RED:uint = 0xDD0000;
    public static const GREEN:uint = 0x00DD00;
    public static const YELLOW:uint = 0xEEEE00;
    public static const BLUE:uint = 0x0000DD;
    
    public var colors:Array = [];
    public var inputColors:Array = [];
    public var current:int = -1;
    public var inputCurrent:int = -1;
    public var timer:Number = 0;
    public var state:String = "display";
    
    public var redSfx:Sfx = new Sfx(RED_SFX);
    public var greenSfx:Sfx = new Sfx(GREEN_SFX);
    public var yellowSfx:Sfx = new Sfx(YELLOW_SFX);
    public var blueSfx:Sfx = new Sfx(BLUE_SFX);
    public var gameOverSfx:Sfx = new Sfx(GAME_OVER_SFX);
    
    public function GameWorld()
    {
      generateColor();
    }
    
    override public function update():void
    {
      if (state == "display")
      {
        if (timer <= 0)
        {
          timer += COLOR_TIME;
          
          if (colors[++current])
          {
            var color:uint = colors[current];
            FP.screen.color = color;
            
            if (color == RED)
            {
              redSfx.play();
            }
            else if (color == GREEN)
            {
              greenSfx.play();
            }
            else if (color == YELLOW)
            {
              yellowSfx.play();
            }
            else if (color == BLUE)
            {
              blueSfx.play();
            }
          }
          else
          {
            state = "input";
            timer = 0;
            current = -1;
            FP.screen.color = 0x111111;
          }
        }
        else
        {
          timer -= FP.elapsed;
        }
      }
      else if (state == "input")
      {
        var red:Boolean = Input.pressed("red");
        var green:Boolean = Input.pressed("green");
        var yellow:Boolean = Input.pressed("yellow");
        var blue:Boolean = Input.pressed("blue");
        var sfx:Sfx;
        
        if (timer <= 0)
        {
          FP.screen.color = 0x111111;
        }
        else
        {
          timer -= FP.elapsed;
        }
        
        if (red)
        {
          inputColors.push(RED);
          sfx = redSfx;
        }
        else if (green)
        {
          inputColors.push(GREEN);
          sfx = greenSfx;
        }
        else if (yellow)
        {
          inputColors.push(YELLOW);
          sfx = yellowSfx;
        }
        else if (blue)
        {
          inputColors.push(BLUE);
          sfx = blueSfx;
        }
        
        if (red || green || yellow || blue)
        {
          if (colors[++inputCurrent] == inputColors[inputCurrent])
          {
            FP.screen.color = inputColors[inputCurrent];
            timer = COLOR_TIME;
            sfx.play();
          }
          else
          {
            // game over
            gameOverSfx.play();
            FP.screen.color = 0x111111;
            FP.world = Black.id;
          }
        }
                
        if (inputCurrent == colors.length - 1)
        {
          inputCurrent = -1;
          inputColors = [];
          generateColor();
          FP.alarm(1, alarmDone, Tween.ONESHOT, this);
        }
      }
    }
    
    private function generateColor():void
    {
      colors.push(FP.choose(RED, GREEN, YELLOW, BLUE));
    }
    
    private function alarmDone():void
    {
      timer = 0;
      state = "display";
    }
  }
}
