import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class BGM {
  static List<AudioCache> _tracks = List<AudioCache>();
  static int _currentTrack = -1;
  static bool _isPlaying = false;
  
  static _BGMWidgetsBindingObserver _bgmwbo;
  
  static _BGMWidgetsBindingObserver get widgetsBindingObserver {
    if (_bgmwbo == null) {
      _bgmwbo = _BGMWidgetsBindingObserver();
    }
    return _bgmwbo;
  }

  static Future _update() async {
    // administra o estado do player, playing ou pausing
    if (_currentTrack == -1) {
      return;
    }
    
    if (_isPlaying) {
      await _tracks[_currentTrack].fixedPlayer.resume();
    }
    else{
      await _tracks[_currentTrack].fixedPlayer.pause();
    }
  }

  
  static Future<void> add(String filename) async {
    /*Esse método possue operaçoes IN e OUT entao tambem precisa ser asyncrono.
    Ele pré-carrega a musica de background dos arquivos de audio.
    Carrega uma nova instancia da classe AudioCache e a adiciona para a lista _tracks.
    Pode ser chamado no começo do jogo para pre-carregar os recursos ou nas telas de loading baseado no qual complexo o jogo é*/
    AudioCache newTrack = AudioCache(prefix: 'audio/', fixedPlayer: AudioPlayer());
    await newTrack.load(filename);
    await newTrack.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);
    _tracks.add(newTrack);
  }


  static void remove(int trackIndex) async {
    /*Esse método aceita um int (trackIndex) como parametro e checa se esse index existe. Se trackIndex for maior ou igual
    ao número de itens da lista _tracks, entao o método usa "return" e termina. */
    if(trackIndex >= _tracks.length) {
      return;
    }
    
    /*Aqui checa se um BGM esta tocando, se _isPlaying for true e o valor atual da track do BGM for o que esta sendo removido
    chama o metodo stop primeiro. Se o BGM tocando for menor na lista do que o que esta sendo removido entao precisamos dar um 
    update na variavel _currentTrack, para seu valor apontar corretamente para o proximo index apos remover um item acima dele   
    */
    if(_isPlaying) {
      if(_currentTrack == trackIndex) {
        await stop();
      }
      if(_currentTrack > trackIndex) {
        _currentTrack -= 1;
      }
    }
    
    /*finalmente removemos o track da lista*/
    _tracks.removeAt(trackIndex);
  }


  static void removeAll() {
    if(_isPlaying) {
      stop();
    }
    _tracks.clear();
  }

  static Future play(int trackIndex) async {
    /*Checa se o trackIndex é o mesmo que o track index tocando atualmente. Se for igual e se estiver tocando, o metodo 
    termina atraves de return. Se for igual mas nao estiver tocando, muda a variavel _isPlaying para true e chama update(),
    terminando com o return
    */
    if (_currentTrack == trackIndex) {
       if(_isPlaying) {
         return;
       }
       _isPlaying = true;
       _update();
       return;
    }
    
    /*Se o valor de trackIndex nao for o mesmo que o track atual, significa que o track que esta tocando esta sendo trocado(mesmo 
    se nenhum estiver tocando). Uma checagem é feita se algo está tocando pelo valor da variavel _isPlaying que por default é false. 
    Se tiver algo tocando, stop() é chamado para se ter certeza que o outro track é parado corretamente 
    */
    if(_isPlaying) {
       await stop();
    }

    _currentTrack = trackIndex;
    _isPlaying = true;
    AudioCache t = _tracks[_currentTrack];
    await t.loop(t.loadedFiles.keys.first);
    //AudioCache nao precisa usar loopLongAudio
    _update();
  }

  static Future stop() async {
    await _tracks [_currentTrack].fixedPlayer.stop();
    _currentTrack = -1;
    _isPlaying = false;
  }

  static void pause() {
    _isPlaying = false;
    _update();
  }

  static void resume() {
    _isPlaying = true;
    _update();
  }

  static void attachWidgetBindingListener() {
    WidgetsBinding.instance.addObserver(BGM.widgetsBindingObserver);
  }

}

class _BGMWidgetsBindingObserver extends WidgetsBindingObserver {
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
       BGM.resume();
    }
    else {
      BGM.pause();
    }
  }  
}