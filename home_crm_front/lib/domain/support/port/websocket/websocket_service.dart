import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/port/websocket/message_dto.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../token_service.dart';

class WebSocketService {
  // 1. Создаем переменную для хранения функции отписки
  void Function({Map<String, String>? unsubscribeHeaders})? _unsubscribeFromOrg;
  StompClient? _client;
  late final TokenService _tokenService = GetIt.instance.get<TokenService>();

  Future<void> initStomp(String orgId) async {
    String? authToken = await _tokenService.getToken(TokenService.authToken);
    print(authToken);
    _client = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws-endpoint',
        onConnect: (frame) => _onConnect(frame, orgId),
        stompConnectHeaders: {
          'Authorization': ?authToken,
          'Organization': orgId,
        },
        webSocketConnectHeaders: {
          'Authorization': ?authToken,
          'Organization': orgId,
        },
        onDisconnect: (frame) => print('Разъединение!'),
        onWebSocketError: (error) => print('Ошибка сети: $error'),
        onStompError: (frame) => print('Ошибка STOMP: ${frame.body}'),

        // --- ГЛАВНЫЕ ПАРАМЕТРЫ ДЛЯ СТАБИЛЬНОСТИ ---

        // Время ожидания перед попыткой переподключения (например, 5 секунд)
        reconnectDelay: const Duration(seconds: 5),

        // Heartbeat (сердцебиение) — критически важно для мобильных сетей.
        // Сервер и клиент обмениваются пустыми пакетами каждые 10 сек,
        // чтобы прокси-серверы и операторы не закрывали «неактивное» соединение.
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),

        // Таймаут для самого соединения
        connectionTimeout: const Duration(seconds: 10),
      ),
    );

    _client?.activate();
  }

  Future<void> sendMessage(String name, Set<int> ids) async {
    // Проверяем, активно ли соединение перед отправкой
    var idOrganization = await _tokenService.getToken(
      TokenService.organizationToken,
    );
    if(_client == null) {
      await initStomp(idOrganization!);
      await Future.delayed(Duration(seconds: 3));
    }
    if (_client != null && _client!.connected && idOrganization != null) {
      try{
      _client?.send(
        destination: '/app/in/${idOrganization}',
        // Путь к контроллеру @MessageMapping
        body: json.encode(MessageDto(name: name, ids: ids).toJson()),
        headers: {
          'content-type': 'application/json',
          // Подсказываем серверу формат данных
        },
      );
      print('Сообщение отправлено на сервер');
      } catch (e) {
        print('Ошибка. Отправка не выполнена.');
        print(e);
      }
    } else {
      print('Ошибка: Соединение не установлено. Отправка невозможна.');
    }
  }

  void _onConnect(StompFrame frame, String orgId) {
    print('Соединение установлено успешно!');

    // ВАЖНО: Подписки нужно оформлять внутри onConnect.
    // При авто-переподключении onConnect вызовется снова,
    // и клиент автоматически переподпишется на топик.
    _unsubscribeFromOrg = _client?.subscribe(
      destination: '/out/$orgId',
      callback: (frame) {
        print('Новое сообщение: ${frame.body}');
      },
    );
  }

  void stopListening() {
    // 2. Вызываем сохраненную функцию для отписки
    if (_unsubscribeFromOrg != null) {
      _unsubscribeFromOrg!();
      _unsubscribeFromOrg = null;
      print('Вы успешно отписались от топика организации');
    }
  }

  void disposeConnection() {
    if (_client != null && _client!.connected) {
      // Метод deactivate корректно закрывает STOMP-сессию и TCP-соединение
      _client!.deactivate();
      print('Соединение с сервером полностью закрыто');
    }
  }
}
