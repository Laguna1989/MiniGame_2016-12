package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
/**
 * ...
 * @author 
 */
class EndGameState extends FlxState
{
    private  var _gameOverText : FlxText;
    private  var _gameOverSubtitle : FlxText;
    private  var _gameStats : FlxText;
    private var _winnerText : FlxText;
    private  var t : Float = 0;
    private  var state : PlayState; 
    public function new(state : PlayState) {
        this.state = state; 
        super();
    }
	public override function create() : Void 

	{
        _gameOverText  = new FlxText(0, FlxG.height / 6, FlxG.width, "game over!", GP.fontSize(3));
        _gameOverText.alignment = "center";
        _gameOverText.font = "assets/data/MECHAG.ttf";
        
        var _gameOverTextFormat : FlxTextFormat = new FlxTextFormat(0xD81B60);
        _gameOverText.addFormat(_gameOverTextFormat);
       
        _gameOverSubtitle = new FlxText(0, GP.fontSize(2)*2.3, GP.ScreenWidth, "press space to restart", GP.fontSize(7));
        var subtitleFormat : FlxTextFormat = new FlxTextFormat(0x00bcd4);

        _gameOverSubtitle = _gameOverSubtitle.addFormat(subtitleFormat, 6, 11 );
        _gameOverSubtitle.font = "assets/data/MECHAG.ttf";
        _gameOverSubtitle.alignment = "center";
        
        var playerTexts : Array<FlxText> = new Array<FlxText>();
        var lowestDeaths : Int = 0xabc;
        
        _winnerText = new FlxText(0, 340, FlxG.width, "", GP.fontSize(6));
        var winText : String = "";
        for (i in 0 ...state._players.length) {
            if (state._players.members[i].deaths < lowestDeaths){
                winText = 'Player ${state._players.members[i]._ID} wins';
                lowestDeaths = state._players.members[i].deaths;
                _winnerText.color = GP.PCols.get(state._players.members[i]._ID);
            }
			else if (state._players.members[i].deaths == lowestDeaths) winText = "Draw!";
			else if (i == state._players.length - 1 && lowestDeaths == 0xabc) {
                winText = 'Draw!';
            }
        }
        _winnerText.text = winText;
        _winnerText.alignment = "center";
        _winnerText.font = "assets/data/MECHAG.ttf";
        add(_winnerText);

        for (i in 0... state._players.length) {
            var p : Player = state._players.members[i];
            var t : FlxText = new FlxText(80 + i*192, 450, 200 - 16 , "", GP.fontSize(6) - 16);
            t.text = "Player: " + Std.string(p._ID);
            t.text += "\nDeaths: " + Std.string(p.deaths);
            t.text += "\nAvg. Damage: " + Std.string(Std.int(p.averageDamage));
            t.text += "\nMax. Damage: " + Std.string(p._highestDamage);
            t.text += "\nPickups: " + Std.string(p._numberOfPickUps);

            t.color = GP.PCols.get(p._ID);
            
            t.font = "assets/data/MECHAG.ttf";
            this.add(t);
             
        }
        add(_gameOverText);
        add(_gameOverSubtitle);

		super.create();
	}
	
	public override function update (elapsed : Float ) : Void 
	{
        t += elapsed *8;
        _gameOverSubtitle.size = Std.int(GP.fontSize(6) - 4 * Math.sin(t));

        if (FlxG.keys.pressed.SPACE) {
		    FlxG.switchState(new StartScreen());
        }

         
    }
	
}
