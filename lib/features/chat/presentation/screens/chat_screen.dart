import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  final List _faqList = [
    {
      'question': '¿Cómo publico mis productos al mayoreo?',
      'answer': '''Ve a la pestaña "Gestión" en el menú inferior, presiona "Añadir producto", completa el nombre, precio por lote, stock disponible y sube una imagen.''',
    },
    {
      'question': '¿Cuáles son las comisiones por venta?',
      'answer': '''Dixema cobra únicamente una comisión del 5% por venta concretada al mayoreo. Publicar y administrar tu catálogo es 100% gratuito.''',
    },
    {
      'question': '¿Cuándo y cómo recibo mis pagos?',
      'answer': '''Los pagos se liberan a tu cuenta bancaria registrada 48 horas después de que el comprador confirma la recepción del pedido en buen estado.''',
    },
    {
      'question': '¿Cómo gestiono los envíos?',
      'answer': '''Puedes usar tu propia flotilla logística o generar guías con nuestras paqueterías aliadas directamente desde el detalle de cada orden.''',
    },
    {
      'question': '¿Cómo subo mis facturas (CFDI)?',
      'answer': '''Una vez aprobado el pedido, encontrarás la opción para adjuntar los archivos XML y PDF de tu factura directamente en el resumen de la venta.''',
    },
  ];

  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      ChatMessage(
        text: '''¡Hola! Estas son las preguntas más frecuentes que necesitas saber como proveedor en Dixema. Selecciona una opción abajo o escribe tu duda:''',
        isMe: false,
      ),
    ];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _selectFaq(String question, String answer) {
    setState(() {
      _messages.add(ChatMessage(text: question, isMe: true));
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(text: answer, isMe: false));
      });
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    final text = _messageCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
      _messageCtrl.clear();
    });
    _scrollToBottom();

    final lowerText = text.toLowerCase();
    String autoReply = '''Gracias por escribirnos. Si deseas ayuda personalizada, selecciona una de las preguntas frecuentes o un asesor te atenderá pronto.''';

    if (lowerText.contains('pago') ||
        lowerText.contains('dinero') ||
        lowerText.contains('cobrar')) {
      autoReply = _faqList[2]['answer'];
    } else if (lowerText.contains('comision') ||
        lowerText.contains('comisión') ||
        lowerText.contains('costo')) {
      autoReply = _faqList[1]['answer'];
    } else if (lowerText.contains('publicar') ||
        lowerText.contains('producto') ||
        lowerText.contains('subir')) {
      autoReply = _faqList[0]['answer'];
    } else if (lowerText.contains('envio') ||
        lowerText.contains('envío') ||
        lowerText.contains('paquete')) {
      autoReply = _faqList[3]['answer'];
    } else if (lowerText.contains('factura') ||
        lowerText.contains('cfdi') ||
        lowerText.contains('rfc')) {
      autoReply = _faqList[4]['answer'];
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(text: autoReply, isMe: false));
      });
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(height: 55, color: AppColors.purpleDark),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 38, bottom: 10, left: 12, right: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Soporte Proveedores Dixema',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueNavy,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 58,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: AppColors.orangePrimary, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 58,
                  right: 8,
                  child: IconButton(
                    tooltip: 'Reiniciar preguntas',
                    icon: const Icon(Icons.refresh_rounded,
                        color: AppColors.orangePrimary, size: 24),
                    onPressed: () {
                      setState(() {
                        _messages = [
                          ChatMessage(
                            text: '''¡Hola! Estas son las preguntas más frecuentes que necesitas saber como proveedor en Dixema. Selecciona una opción abajo o escribe tu duda:''',
                            isMe: false,
                          ),
                        ];
                      });
                    },
                  ),
                ),
                const Positioned(
                  top: 22,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: Color(0xFFB2DFDB),
                      child: Icon(Icons.support_agent_rounded,
                          size: 36, color: AppColors.blueNavy),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Asistente Automatizado • En línea',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueNavy,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollCtrl,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildChatBubble(msg);
                },
              ),
            ),
            Container(
              height: 44,
              margin: const EdgeInsets.only(top: 6),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _faqList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final faq = _faqList[index];
                  return ActionChip(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                        color: AppColors.orangePrimary, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      faq['question'],
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleDark,
                      ),
                    ),
                    onPressed: () =>
                        _selectFaq(faq['question'], faq['answer']),
                  );
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: AppColors.backgroundLight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3ECFA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageCtrl,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: const InputDecoration(
                          hintText: 'Escribe una pregunta...',
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.black54),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.orangePrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send_rounded,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    final Color bubbleColor =
        msg.isMe ? AppColors.orangePrimary : AppColors.purpleDark;

    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment:
              msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.72),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: msg.isMe ? Radius.zero : const Radius.circular(20),
                  bottomLeft:
                      msg.isMe ? const Radius.circular(20) : Radius.zero,
                  bottomRight: const Radius.circular(20),
                ),
              ),
              child: Text(
                msg.text,
                style: const TextStyle(
                    color: Colors.white, fontSize: 13, height: 1.35),
              ),
            ),
            const SizedBox(height: 3),
            const Icon(Icons.done_all_rounded, size: 14, color: Colors.green),
          ],
        ),
      ),
    );
  }
}