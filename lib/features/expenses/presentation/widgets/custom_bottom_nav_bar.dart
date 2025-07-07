import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final VoidCallback onPlusTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onPlusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavBarIcon(
                    
                    icon: Icons.home_filled,
                    selected: selectedIndex == 0,
                    onTap: () => onTabSelected(0),
                  ),
                  _AssetNavBarIcon(
                    asset: 'assets/icons/chart.png',
                    selected: selectedIndex == 1,
                    onTap: () => onTabSelected(1),
                  ),
                  const SizedBox(width: 56), // مساحة زرار +
                  _AssetNavBarIcon(
                    asset: 'assets/icons/wallet.png',
                    selected: selectedIndex == 2,
                    onTap: () => onTabSelected(2),
                  ),
                  _AssetNavBarIcon(
                    asset: 'assets/icons/person.png',
                    selected: selectedIndex == 3,
                    onTap: () => onTabSelected(3),
                  ),
                ],
              ),
              // زرار + دائري في المنتصف
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: onPlusTap,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F57E7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.13),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add, size: 32, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// أيقونة Flutter للهوم فقط
class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 35,
        color: selected ? const Color(0xFF2F57E7) : Colors.grey[350],
      ),
      onPressed: onTap,
    );
  }
}

// أيقونة صورة (png) للـ Chart/Wallet/Person
class _AssetNavBarIcon extends StatelessWidget {
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  const _AssetNavBarIcon({
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        asset,
        width: 35,
        height: 35,
        color: selected ? const Color(0xFF2F57E7) : const Color.fromARGB(255, 96, 95, 95),
      ),
      onPressed: onTap,
    );
  }
}