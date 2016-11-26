package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var _gameTitle : FlxText;
    private var _gameSubtitle : FlxText;
    // the int denotes the player number, the bool is true if the player pressed 'A'
    private var _playerTexts : Map<Int, Bool> = new Map<Int, Bool>();
  	private var t : Float = 0;
    
	//
	//private var arr : Array<Int> = new Array<Int>();
	//private var map : Map<Int, String> = new Map<Int,String>();
	//
	//
	
	override public function create():Void
	{
		super.create();
        for (player in 0 ... 4) {
            _playerTexts.set(player, false);
        }
        
        for (player in 0 ... 4) {
            trace('Is the player connected?: $_playerTexts[player] ');
        }

		FlxG.mouse.visible = false;
        
        // tasty spaghetti incoming!
		_gameTitle = new FlxText(0, GP.fontSize(3), GP.ScreenWidth, "pushover\n", GP.fontSize(3));
        _gameSubtitle = new FlxText(0, GP.fontSize(3)*2.3, GP.ScreenWidth, "a really nice game", GP.fontSize(6));

	    _gameTitle.alignment = "center";	
        _gameSubtitle.alignment = "center";

        var format : FlxTextFormat= new FlxTextFormat(0xD81B60);
        _gameTitle = _gameTitle.addFormat(format, -1, -1);

         add(_gameTitle);
         add(_gameSubtitle);
         
         // add the players
		GP.PCols = new PlayerColors();
		//_startText = new FlxText( 100, 100, 0, "pushover, press Space to start", 16);
        // contains the "player<x>: press A to join" messages
        //_playerText = new Array<String>();
		//add(_startText);
        //add(_playerText);	
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

       t += elapsed*8;
       _gameSubtitle.size = Std.int(GP.fontSize(6) - 4 * Math.sin(t));
		//_text.update(elapsed);
		if (FlxG.keys.pressed.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
        
	}
	
	override public function draw():Void
	{
		super.draw();
		//_text.draw();
	}
}
