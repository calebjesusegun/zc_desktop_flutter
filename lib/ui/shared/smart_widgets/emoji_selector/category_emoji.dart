
import 'package:zc_desktop_flutter/ui/shared/smart_widgets/emoji_selector/emoji.dart';

import 'emoji_picker.dart';

/// Container for Category and their emoji
class CategoryEmoji {
  /// Constructor
  CategoryEmoji(this.category, this.emoji);

  /// Category instance
  final Category category;

  /// List of emoji of this category
  List<Emoji> emoji;
}