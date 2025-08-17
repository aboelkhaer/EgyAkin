# Deep Linking Implementation for EgyAkin

This document explains how deep linking is implemented in the EgyAkin app to allow sharing posts and opening them directly in the app.

## Overview

The deep linking system allows users to:
1. Share posts using a deep link URL
2. Open the app directly to a specific post when clicking on a shared link
3. Handle both authenticated and unauthenticated users

## Implementation Details

### 1. Deep Link URL Format

Posts are shared using the following URL format:
```
https://{YOUR_BASE_URL}/post/{postId}
```

Example:
```
https://{YOUR_BASE_URL}/post/123
```

### 2. Configuration Files

#### Android (android/app/src/main/AndroidManifest.xml)
```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="https" android:host="{YOUR_BASE_URL}" />
    <data android:scheme="https" android:host="api.egyakin.com" />
    <data android:scheme="https" android:host="egyakin.com" />
</intent-filter>
```

#### iOS (ios/Runner/Info.plist)
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>api.egyakin.com</string>
            <string>egyakin.com</string>
        </array>
        <key>CFBundleURLName</key>
        <string>com.incode.EgyAkin</string>
    </dict>
</array>
```

### 3. Core Components

#### DeepLinkHandler (lib/app/services/deep_link_handler.dart)
- Handles incoming deep links
- Parses URL paths to extract post IDs
- Stores pending deep links for later processing

#### DeepLinkNavigationService (lib/app/services/deep_link_navigation_service.dart)
- Handles navigation to ShowSingleFeedScreen
- Fetches post data using the post ID
- Manages user authentication state
- Shows appropriate error messages

#### ShareButton (lib/features/community/presentation/widgets/share_button.dart)
- Generates deep link URLs for sharing
- Uses DeepLinkHandler to create consistent URLs
- Includes app store links as fallbacks

### 4. Flow Diagram

```
User clicks share button
         ↓
Generate deep link URL
         ↓
Share URL with user
         ↓
User clicks shared link
         ↓
App opens and processes deep link
         ↓
Fetch post data by ID
         ↓
Check user authentication
         ↓
Navigate to ShowSingleFeedScreen
```

### 5. Error Handling

The system handles various error scenarios:
- **Network errors**: Shows error dialog with retry option
- **Invalid post ID**: Shows "Post not found" message
- **Unauthenticated user**: Prompts user to log in
- **App not installed**: Redirects to app store

### 6. Testing

To test deep linking:

1. **Development testing**:
   ```bash
   # Android
   adb shell am start -W -a android.intent.action.VIEW -d "https://api.egyakin.com/post/123" com.incode.EgyAkin
   
   # iOS (using Simulator)
   xcrun simctl openurl booted "https://api.egyakin.com/post/123"
   ```

2. **Production testing**:
   - Share a post using the share button
   - Click the shared link on a different device
   - Verify the app opens and navigates to the correct post

### 7. Dependencies

The implementation uses these packages:
- `app_links`: For handling deep links
- `share_plus`: For sharing functionality
- `shared_preferences`: For storing pending deep links

### 8. Security Considerations

- Deep links are validated before processing
- User authentication is checked before showing sensitive content
- Error messages don't expose internal system details

## Usage

### For Developers

1. **Adding new deep link types**:
   - Update `DeepLinkHandler._handleDeepLink()` method
   - Add new case in the switch statement
   - Create corresponding navigation logic

2. **Modifying share content**:
   - Update `ShareButton` widget
   - Modify the share text format
   - Update app store URLs if needed

### For Users

1. **Sharing posts**:
   - Tap the share button on any post
   - Choose your preferred sharing method
   - The link will open the app directly to that post

2. **Opening shared links**:
   - Click on a shared EgyAkin post link
   - The app will open automatically
   - If not logged in, you'll be prompted to sign in first

## Troubleshooting

### Common Issues

1. **Deep link not working**:
   - Check if the app is properly configured in AndroidManifest.xml and Info.plist
   - Verify the URL format matches the expected pattern
   - Ensure the post ID is valid

2. **App crashes when opening deep link**:
   - Check if all required data (user model, home data) is available
   - Verify the ShowSingleFeedScreen route is properly configured
   - Check for null safety issues in the navigation service

3. **Deep link opens but shows wrong content**:
   - Verify the post ID is being correctly parsed from the URL
   - Check if the API call to fetch post data is working
   - Ensure the navigation arguments are correct

### Debug Information

Enable debug logging by checking the console output for:
- "Handling deep link: [URL]"
- "Navigating to post: [postId]"
- "Error navigating to post from deep link: [error]" 