import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'signaling_service.dart';

class WebRTCCallService {
  RTCPeerConnection? peerConnection;
  RTCDataChannel? dataChannel;
  final SignalingService _signalingService = SignalingService();

  final _messageController = StreamController<String>.broadcast();

  Stream<String> get onMessage => _messageController.stream;

  final _connectionStateController = StreamController<String>.broadcast();

  Stream<String> get onConnectionState => _connectionStateController.stream;

  Future<void> initializePeerConnection(String userId, String peerId,
      {required void Function(String log) onLog,
      required void Function(RTCPeerConnectionState state)
          onConnectionStateChange}) async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
        {'urls': 'stun:stun2.l.google.com:19302'},
      ],
    };

    try {
      peerConnection = await createPeerConnection(configuration);
      _connectionStateController.add('Peer connection created');

      peerConnection!.onIceCandidate = (candidate) {
        if (candidate == null) {
          print('ICE gathering complete');
          _connectionStateController.add('ICE gathering complete');
        } else {
          print('ICE candidate: ${candidate.toMap()}');
          _signalingService.sendSignal(userId, peerId, {
            'type': 'ice_candidate',
            'candidate': candidate.toMap(),
          });
        }
      };

      peerConnection!.onConnectionState = (state) {
        print('Connection state change: $state');
        _connectionStateController.add('Connection state: $state');
      };

      peerConnection!.onDataChannel = (channel) {
        print('Data channel received: ${channel.label}');
        dataChannel = channel;
        _setupDataChannel();
      };

      _listenForSignals(userId, peerId);
    } catch (e) {
      print('Error initializing peer connection: $e');
      _connectionStateController.add('Error: $e');
      rethrow;
    }
  }

  void _listenForSignals(String userId, String peerId) {
    _signalingService.onSignalReceived(userId).listen((signalDataList) {
      for (var signalData in signalDataList) {
        _handleSignal(signalData, peerId);
      }
    }, onError: (error) {
      print('Error receiving signal: $error');
      _connectionStateController.add('Signaling error: $error');
    });
  }

  Future<void> _handleSignal(
      Map<String, dynamic> signalData, String peerId) async {
    try {
      switch (signalData['type']) {
        case 'offer':
          await _handleOffer(signalData, peerId);
          break;
        case 'answer':
          await _handleAnswer(signalData);
          break;
        case 'ice_candidate':
          await _handleIceCandidate(signalData);
          break;
        default:
          print('Unknown signal type: ${signalData['type']}');
      }
    } catch (e) {
      print('Error handling signal: $e');
      _connectionStateController.add('Error handling signal: $e');
    }
  }

  Future<void> createOffer(String userId, String peerId) async {
    try {
      dataChannel =
          await peerConnection!.createDataChannel('chat', RTCDataChannelInit());
      _setupDataChannel();

      RTCSessionDescription offer = await peerConnection!.createOffer();
      await peerConnection!.setLocalDescription(offer);

      _signalingService.sendSignal(userId, peerId, {
        'type': 'offer',
        'sdp': offer.toMap(),
      });

      _connectionStateController.add('Offer sent');
    } catch (e) {
      print('Error creating offer: $e');
      _connectionStateController.add('Error creating offer: $e');
    }
  }

  Future<void> _handleOffer(
      Map<String, dynamic> signalData, String peerId) async {
    try {
      await peerConnection!.setRemoteDescription(
        RTCSessionDescription(
            signalData['sdp']['sdp'], signalData['sdp']['type']),
      );

      RTCSessionDescription answer = await peerConnection!.createAnswer();
      await peerConnection!.setLocalDescription(answer);

      _signalingService.sendSignal('yourUserId', peerId, {
        'type': 'answer',
        'sdp': answer.toMap(),
      });

      _connectionStateController.add('Answer sent');
    } catch (e) {
      print('Error handling offer: $e');
      _connectionStateController.add('Error handling offer: $e');
    }
  }

  Future<void> _handleAnswer(Map<String, dynamic> signalData) async {
    try {
      await peerConnection!.setRemoteDescription(
        RTCSessionDescription(
            signalData['sdp']['sdp'], signalData['sdp']['type']),
      );
      _connectionStateController.add('Remote description set');
    } catch (e) {
      print('Error handling answer: $e');
      _connectionStateController.add('Error handling answer: $e');
    }
  }

  Future<void> _handleIceCandidate(Map<String, dynamic> signalData) async {
    try {
      if (peerConnection != null) {
        await peerConnection!.addCandidate(
          RTCIceCandidate(
            signalData['candidate']['candidate'],
            signalData['candidate']['sdpMid'],
            signalData['candidate']['sdpMLineIndex'],
          ),
        );
        print('ICE candidate added successfully');
      } else {
        print('PeerConnection is null, cannot add ICE candidate');
      }
    } catch (e) {
      print('Error adding ICE candidate: $e');
      _connectionStateController.add('Error adding ICE candidate: $e');
    }
  }

  void _setupDataChannel() {
    dataChannel?.onMessage = (message) {
      print('Received message: ${message.text}');
      _messageController.add(message.text);
    };

    dataChannel?.onDataChannelState = (state) {
      print('Data channel state changed: $state');
      _connectionStateController.add('Data channel state: $state');
    };
  }

  void sendMessage(String message) {
    if (dataChannel?.state == RTCDataChannelState.RTCDataChannelOpen) {
      dataChannel?.send(RTCDataChannelMessage(message));
    } else {
      print('Data channel is not open. Current state: ${dataChannel?.state}');
      _connectionStateController
          .add('Cannot send message: Data channel is not open');
    }
  }

  Future<void> dispose() async {
    await dataChannel?.close();
    await peerConnection?.close();
    await _messageController.close();
    await _connectionStateController.close();
  }
}
