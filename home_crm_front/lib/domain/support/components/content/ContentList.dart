import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../../sub/organization/organization_test_page.dart';
import '../callback/NavBarCallBack.dart';
import '../sheetbar/sheet_bar_page.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList>
    with TickerProviderStateMixin {
  final LinkedHashMap<String, SheetPage> _contents = LinkedHashMap();
  late TabController _tabController;
  String select = '';

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер с начальной длиной списка
    _tabController = TabController(length: _contents.length, vsync: this);
    // Добавляем слушатель, чтобы отлавливать изменения индекса
    _tabController.addListener(_handleTabChange);
  }

  // Вынесенная функция для инициализации/переинициализации контроллера
  void _initializeTabController() {
    // Если контроллер уже существует, сначала освобождаем его ресурсы
    _tabController.dispose();
    _tabController = TabController(length: _contents.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // Этот setState обновляет UI, если вам нужно отобразить
    // что-то еще при переключении вкладок
    var elementAt = _contents.keys.toList().elementAt(_tabController.index);
    if (select != elementAt) {
      setState(() {
        select = elementAt;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  // Функция для динамического добавления новой вкладки
  void _addTab(SheetPage page) {
    setState(() {
      if (!_contents.containsKey(page.getName())) {
        _contents[page.getName()] = page;
        select = page.getName();
        // *** Важно: Нужно пересоздать TabController с новой длиной ***
        _initializeTabController();
        // Опционально: переключиться на новую вкладку
        _tabController.index = _contents.length - 1;
      } else {
        _tabController.index = _contents.keys.toList().indexOf(page.getName());
      }
    });
  }

  // --- Функция УДАЛЕНИЯ вкладки ---
  void _removeTab(String index) {
    setState(() {
      // Запоминаем текущий выбранный индекс
      int previousIndex = _tabController.index;

      // Удаляем элемент из списка
      _contents.remove(index);

      // *** Важный шаг: Пересоздаем TabController с новой длиной ***
      _initializeTabController();

      // Логика выбора новой активной вкладки после удаления:
      if (_contents.isNotEmpty) {
        // Если удалили текущую вкладку (или вкладку правее текущей),
        // остаемся на том же или предыдущем индексе
        int newIndex = previousIndex;

        if (newIndex >= _contents.length) {
          // Если индекс вышел за пределы нового списка, выбираем последний элемент
          newIndex = _contents.length - 1;
        }

        // Устанавливаем новый индекс
        _tabController.index = newIndex;
        select = _contents.keys.toList().elementAt(_tabController.index);
      }
    });
  }

  _ContentListState() {
    GetIt.I.get<SheetElementAddCallback>().subscribe((page) {
      _addTab(page);
    });
    GetIt.I.get<SheetElementDeleteCallback>().subscribe((page) {
      _removeTab(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Наш динамический TabBar
        Container(
          color: CustomColors.getSecondaryBackground(context),
          child: TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            // Позволяет вкладкам прокручиваться горизонтально
            labelColor: CustomColors.getPrimaryText(context),
            unselectedLabelColor: CustomColors.getSecondaryText(context),
            labelStyle: CustomColors.getTitleSmall(context, null),
            // indicatorColor: CustomColors.getPrimary(context),
            indicatorColor: Colors.transparent,
            // indicatorSize: TabBarIndicatorSize.tab,
            // dividerColor: CustomColors.getAlternate(context),
            dividerColor: CustomColors.getPrimaryBackground(context),
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            dividerHeight: 2,
            splashBorderRadius: BorderRadius.circular(12),
            overlayColor: WidgetStateProperty.all(
              CustomColors.getSecondaryBackground(context),
            ),
            tabs: _contents.keys.map((key) {
              return Container(
                height: 44,
                width: 200,
                decoration: BoxDecoration(
                  color: key == select
                      ? CustomColors.getPrimaryBackground(context)
                      : CustomColors.getSecondaryBackground(context),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: key == select
                        ? Radius.zero
                        : Radius.circular(12),
                    bottomRight: key == select
                        ? Radius.zero
                        : Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: CustomColors.getPrimaryBackground(context),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: CustomColors.getPrimaryBackground(context),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: CustomColors.getPrimaryBackground(context),
                      width: 1,
                    ),
                    right: BorderSide(
                      color: CustomColors.getPrimaryBackground(context),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(8, 3, 8, 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // FadeableTab(text: key,),
                      Expanded(
                        child: Text(
                          key,
                          maxLines: 1, // Ограничиваем одной строкой
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        onPressed: () => _removeTab(key),
                        icon: Icon(Icons.close, size: 16),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // 2. TabBarView должен быть обернут в Expanded или иметь явные ограничения высоты
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _contents.values.map((page) {
              // Создаем контент для каждой вкладки динамически
              return page;
            }).toList(),
            // children: _contents.values.map((page) {
            //   // Создаем контент для каждой вкладки динамически
            //   return SingleChildScrollView(primary: true, child: page);
            // }).toList(),
          ),
        ),
      ],
    );
  }
}

class DynamicTabsScreen extends StatefulWidget {
  const DynamicTabsScreen({super.key});

  @override
  _DynamicTabsScreenState createState() => _DynamicTabsScreenState();
}

class _DynamicTabsScreenState extends State<DynamicTabsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Динамический список данных для вкладок
  List<String> _tabTitles = ['Главная', 'Настройки', 'Профиль'];

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер с начальной длиной списка
    _tabController = TabController(length: _tabTitles.length, vsync: this);

    // Добавляем слушатель, чтобы отлавливать изменения индекса
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // Этот setState обновляет UI, если вам нужно отобразить
    // что-то еще при переключении вкладок
    setState(() {
      // Можно использовать _tabController.index для получения текущей вкладки
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  // Функция для динамического добавления новой вкладки
  void _addTab() {
    setState(() {
      final newTitle = 'Вкладка ${_tabTitles.length + 1}';
      _tabTitles.add(newTitle);

      // *** Важно: Нужно пересоздать TabController с новой длиной ***
      _tabController.dispose();
      _tabController = TabController(length: _tabTitles.length, vsync: this);

      // Опционально: переключиться на новую вкладку
      _tabController.index = _tabTitles.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Мы используем обычный Container вместо Scaffold
    return Container(
      width: 500,
      height: 500,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 40.0),
      // Добавляем отступ сверху для SafeArea
      child: Column(
        children: [
          // 1. Наш динамический TabBar
          TabBar(
            controller: _tabController,
            isScrollable: true,
            // Позволяет вкладкам прокручиваться горизонтально
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
          ),

          // Кнопка добавления вкладки (для демонстрации динамичности)
          ElevatedButton(
            onPressed: _addTab,
            child: const Text('Добавить новую вкладку'),
          ),

          // 2. TabBarView должен быть обернут в Expanded или иметь явные ограничения высоты
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabTitles.map((title) {
                // Создаем контент для каждой вкладки динамически
                return OrganizationTestsPage();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FadeableTab extends StatelessWidget {
  final String text;

  const FadeableTab({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Явно ограничиваем ширину вкладки для примера
      width: 25,
      alignment: Alignment.center,
      child: ShaderMask(
        // Создаем линейный градиент, который переходит от
        // 100% видимости (белый) к 0% видимости (прозрачный) на последних 20% ширины.
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // Цвета градиента должны быть белыми, меняется только их прозрачность (opacity)
            colors: [Colors.white, Colors.white.withOpacity(0.0)],
            // Останавливаем градиент так, чтобы он начинался затухать после 80% длины
            stops: const [0.0, 0.8, 1.0],
          ).createShader(bounds);
        },
        // BlendMode.dstOut оставляет только ту часть текста,
        // которая не скрыта маской градиента.
        blendMode: BlendMode.dstOut,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // Позволяем тексту прокручиваться внутри
          child: Text(
            text,
            maxLines: 1,
            // Цвет текста должен быть тот же, что и у labelColor TabBar
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}