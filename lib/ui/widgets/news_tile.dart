import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_list_screen/data/Model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatefulWidget {
  final NewsModel news;

  const NewsTile({required this.news});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool _isHovered = false;

  Future<void> _openUrl() async {
    final Uri url = Uri.parse(widget.news.url);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Color(0xFF667EEA).withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _isHovered ? 16 : 12,
              offset: Offset(0, _isHovered ? 6 : 4),
            ),
          ],
          border: Border.all(
            color: _isHovered
                ? Color(0xFF667EEA).withOpacity(0.5)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
          child: InkWell(
            onTap: _openUrl,
            borderRadius: BorderRadius.circular(16),
            highlightColor: Color(0xFF667EEA).withOpacity(0.1),
            splashColor: Color(0xFF667EEA).withOpacity(0.15),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Image.network(
                              widget.news.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF667EEA),
                                        Color(0xFF764BA2),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                );
                              },
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF6B6B),
                                Color(0xFFEE5A6F),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF6B6B).withOpacity(0.5),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      if (_isHovered)
                        Positioned(
                          bottom: 6,
                          left: 6,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF00D4FF).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00D4FF).withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Text(
                              'TAP',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 12),                
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.news.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.35,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF667EEA).withOpacity(0.2),
                                Color(0xFF764BA2).withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Color(0xFF667EEA).withOpacity(0.4),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            widget.news.source,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00D4FF),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 4),
                            Text(
                              formatDate(widget.news.date),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AnimatedOpacity(
                      opacity: _isHovered ? 1.0 : 0.5,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedSlide(
                        offset: _isHovered ? Offset(0.2, 0) : Offset(0, 0),
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          size: 18,
                          color: Color(0xFF00D4FF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
