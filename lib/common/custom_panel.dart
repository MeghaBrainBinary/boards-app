import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';

Widget customPlayPausePanel(
    FijkPlayer player,
    FijkData data,
    BuildContext context,
    Size viewSize,
    Rect texturePos) {
  return Stack(
    children: <Widget>[
      // Loader in the center while the video is loading or buffering
      Align(
        alignment: Alignment.center,
        child: _LoadingIndicator(player: player),
      ),
      // Play/Pause button with tap detector for showing/hiding the button
      Align(
        alignment: Alignment.center,
        child: _TapDetector(player: player),
      ),
    ],
  );
}

class _LoadingIndicator extends StatefulWidget {
  final FijkPlayer player;

  _LoadingIndicator({Key? key, required this.player}) : super(key: key);

  @override
  __LoadingIndicatorState createState() => __LoadingIndicatorState();
}

class __LoadingIndicatorState extends State<_LoadingIndicator> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_onPlayerStateChanged);
    _isLoading = widget.player.state != FijkState.started && widget.player.state != FijkState.paused;
  }

  void _onPlayerStateChanged() {
    if (mounted) {
      setState(() {
        _isLoading = widget.player.state != FijkState.started && widget.player.state != FijkState.paused;
      });
    }
  }

  @override
  void dispose() {
    widget.player.removeListener(_onPlayerStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isLoading,
      child: CircularProgressIndicator(),
    );
  }
}

class _TapDetector extends StatefulWidget {
  final FijkPlayer player;

  _TapDetector({Key? key, required this.player}) : super(key: key);

  @override
  __TapDetectorState createState() => __TapDetectorState();
}

class __TapDetectorState extends State<_TapDetector> {
  bool _showButton = false; // Initially hide the button
  bool _isPlaying = false;
  bool _isVideoReady = false;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_onPlayerStateChanged);
    _isPlaying = widget.player.state == FijkState.started;
    _isVideoReady = widget.player.state == FijkState.prepared || widget.player.state == FijkState.started || widget.player.state == FijkState.paused;
    _showButton =true;
  }

  void _onPlayerStateChanged() {
    if (mounted) {
      setState(() {
        _isPlaying = widget.player.state == FijkState.started;
        _isVideoReady = widget.player.state == FijkState.prepared || widget.player.state == FijkState.started || widget.player.state == FijkState.paused;
        if (_isPlaying) {
          _showButton = false; // Hide button when playing
        }
      });
    }
  }

  void _toggleButtonVisibility() {
    setState(() {
      _showButton = true; // Show the button when tapping on the video
    });

    // Auto-hide the button after a short delay if the video is still playing
    if (_isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isPlaying) {
          setState(() {
            _showButton = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    widget.player.removeListener(_onPlayerStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleButtonVisibility,
      child: Visibility(
        visible: _isVideoReady && _showButton,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,// Show button when video is ready and _showButton is true
        child: IconButton(
          iconSize: 64.0,
          icon: Icon(
            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            color: Colors.white,
          ),
          onPressed: () {
            if (_isPlaying) {
              widget.player.pause();
              setState(() {
                _isPlaying = false;
                _showButton = true; // Show button when paused
              });
            } else {
              widget.player.start();
              setState(() {
                _isPlaying = true;
                _showButton = false; // Hide button when playing
              });
            }
          },
        ),
      ),
    );
  }
}
