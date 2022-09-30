part of '../joke_screen.dart';

class _AppBar extends StatefulWidget with PreferredSizeWidget {
  const _AppBar();

  @override
  State<_AppBar> createState() => _AppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarState extends State<_AppBar> {
  final isDark = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      )),
      backgroundColor: const Color(0xff141111).withOpacity(0.5),
      elevation: 0,
      title: const Text(
        'DAD JOKES',
        style: TextStyle(
          letterSpacing: -2,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            isDark.value = !isDark.value;
            context.read<ThemeProvider>().changeTheme(isDark.value);
          },
          icon: ValueListenableBuilder(
              valueListenable: isDark,
              builder: (context, _, __) {
                return Visibility(
                  visible: isDark.value,
                  replacement: SvgPicture.asset(
                    'assets/svgs/sun.svg',
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/moon.svg',
                    color: Colors.white,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
