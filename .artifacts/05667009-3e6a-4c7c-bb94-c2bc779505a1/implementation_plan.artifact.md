# Implementation Plan - UI Enhancements and Smooth Scrolling Animations

This plan addresses the UI updates for the side panel (hamburger menu) and the home screen's scrollable section (which the user refers to as the "drawer").

## Proposed Changes

### [Screens]

#### [MODIFY] [home_page.dart](file:///C:/Users/adnan/AndroidStudioProjects/flutterproj/lib/screens/home_page.dart)

- **Side Panel (Hamburger Menu):**
    - Update the background color to a light blue-tinted color: `Color(0xFFF1F4F9)`.
- **Home Screen Layout Transformation:**
    - Re-architect the `body` to use a `CustomScrollView` with a `SliverAppBar`.
    - **SliverAppBar:**
        - `pinned: true`, `expandedHeight: 180.0`.
        - `leading`: Hamburger menu button.
        - `actions`: Calendar icon.
        - `flexibleSpace`: A custom widget that displays "Welcome Back," and "FixIt Support".
        - **Animation:** Use a `LayoutBuilder` to monitor the scroll progress. As the bar collapses:
            - The "FixIt Support" text will smoothly transition (scale and move) to become the "FixIt" company name in the center of the pinned app bar.
- **The "Drawer" (Home Screen Scrollable Section):**
    - The section currently containing the `GridView` will be wrapped in a `SliverToBoxAdapter`.
    - It will have a `BoxDecoration` with a large top border radius (e.g., 40.0).
    - As the user scrolls up, this section will "come up" and cover the header area smoothly, giving the appearance of a drawer sliding over the background.

## Verification Plan

### Manual Verification
- **Side Panel:** Open the side panel and verify the background color is the new light blue tint.
- **Scrolling Animation:**
    - Scroll up on the home page.
    - Verify that the grid section slides up and covers the header.
    - Verify that the "FixIt Support" text smoothly animates into a smaller "FixIt" title in the top bar.
- **Theme Consistency:** Check both light and dark modes to ensure legibility and style consistency.
