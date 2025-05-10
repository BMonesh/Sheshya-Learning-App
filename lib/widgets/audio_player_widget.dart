import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final Color color;

  const AudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.color,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioLoaded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadAudio();
    
    // Listen for audio completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _animationController.stop();
        });
      }
    });
  }

  Future<void> _loadAudio() async {
    try {
      // For assets
      if (widget.audioUrl.startsWith('assets/')) {
        await _audioPlayer.setSource(AssetSource(widget.audioUrl.replaceFirst('assets/', '')));
      } else {
        // For network URLs
        await _audioPlayer.setSource(UrlSource(widget.audioUrl));
      }
      setState(() {
        _isAudioLoaded = true;
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (!_isAudioLoaded) {
      return;
    }
    
    if (_isPlaying) {
      await _audioPlayer.pause();
      _animationController.stop();
    } else {
      await _audioPlayer.resume();
      _animationController.repeat(reverse: true);
    }
    
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              size: 60,
              color: widget.color,
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 20 + (index % 3) * 10 * (_animationController.value + 0.2),
                      width: 6,
                      decoration: BoxDecoration(
                        color: _isPlaying ? widget.color : widget.color.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (!_isAudioLoaded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Loading audio...',
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}