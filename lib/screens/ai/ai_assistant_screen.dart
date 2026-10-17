import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/restaurant.dart';
import '../../theme/app_theme.dart';
import '../home/widgets/restaurant_card.dart';
import '../restaurant/restaurant_detail_screen.dart';

class _ChatMessage {
  final String text;
  final bool isUser;
  final List<Restaurant>? suggestions;
  _ChatMessage(this.text, this.isUser, {this.suggestions});
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];

  final List<String> _suggestions = [
    'Spicy biryani under Rs.700 near me',
    'Cheap burgers for 2 people',
    'Something quick, under 30 minutes',
    'Best rated pizza nearby',
  ];

  @override
  void initState() {
    super.initState();
    _messages.add(_ChatMessage(
      "Hi! I'm your King's Foodz AI assistant 👑\nTell me what you're craving — like \"spicy biryani under Rs.700 within 1km\" — and I'll find the best match for you.",
      false,
    ));
  }

  void _send([String? text]) {
    final query = (text ?? _controller.text).trim();
    if (query.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(query, true));
      _controller.clear();
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 500), () {
      final matches = _mockMatch(query);
      setState(() {
        _messages.add(_ChatMessage(
          matches.isEmpty
              ? "I couldn't find an exact match, but here are some popular picks near you:"
              : "Here's what I found based on your request:",
          false,
          suggestions: matches.isEmpty ? MockData.restaurants.take(2).toList() : matches,
        ));
      });
      _scrollToBottom();
    });
  }

  List<Restaurant> _mockMatch(String query) {
    final q = query.toLowerCase();
    return MockData.restaurants.where((r) {
      final matchesCuisine = r.cuisine.toLowerCase().contains(q.split(' ').first);
      final matchesMenu = r.menu.any((f) => q.split(' ').any((word) => f.name.toLowerCase().contains(word)));
      return matchesCuisine || matchesMenu;
    }).take(3).toList();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome_rounded, color: AppColors.gold),
            SizedBox(width: 8),
            Text('AI Food Assistant'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final msg = _messages[i];
                return Column(
                  crossAxisAlignment: msg.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                        decoration: BoxDecoration(
                          color: msg.isUser ? AppColors.maroon : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(color: msg.isUser ? Colors.white : AppColors.charcoal, height: 1.4),
                        ),
                      ),
                    ),
                    if (msg.suggestions != null)
                      ...msg.suggestions!.map((r) => RestaurantCard(
                            restaurant: r,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: r)),
                            ),
                          )),
                  ],
                );
              },
            ),
          ),
          if (_messages.length <= 1)
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _suggestions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => ActionChip(
                  label: Text(_suggestions[i], style: const TextStyle(fontSize: 12.5)),
                  onPressed: () => _send(_suggestions[i]),
                ),
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(hintText: 'Ask for anything you\'re craving...'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.maroon,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      onPressed: _send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
