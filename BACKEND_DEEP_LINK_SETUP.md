# Backend Deep Link Setup Guide

This guide explains what the backend needs to implement to make deep linking work properly.

## Problem
When users click on shared post links, they open in the browser instead of redirecting to the app. This happens because the browser doesn't know how to handle the custom URL scheme.

## Solution
The backend needs to serve special files that tell the operating system how to handle these URLs.

## Required Backend Implementation

### 1. Universal Links Configuration (Recommended)

#### For iOS - Apple App Site Association
Create a file at: `https://{YOUR_BASE_URL}/.well-known/apple-app-site-association`

**Content:**
```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.incode.EgyAkin",
        "paths": ["/post/*"]
      }
    ]
  }
}
```

**Important Notes:**
- Replace `TEAM_ID` with your actual Apple Developer Team ID
- The file must be served with `Content-Type: application/json`
- Must be accessible via HTTPS
- No file extension (don't name it `.json`)

#### For Android - Digital Asset Links
Create a file at: `https://{YOUR_BASE_URL}/.well-known/assetlinks.json`

**Content:**
```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.incode.EgyAkin",
      "sha256_cert_fingerprints": ["YOUR_APP_SIGNING_CERTIFICATE_SHA256"]
    }
  }
]
```

**Important Notes:**
- Replace `YOUR_APP_SIGNING_CERTIFICATE_SHA256` with your actual app signing certificate SHA256
- Must be served with `Content-Type: application/json`
- Must be accessible via HTTPS

### 2. HTML Redirect Page (Fallback)

If Universal Links can't be set up immediately, create an HTML page that handles the redirect:

**URL Pattern:** `https://{YOUR_BASE_URL}/post/{postId}`

**HTML Content:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>Opening EgyAkin...</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
</head>
<body>
    <script>
        // Extract post ID from URL
        const pathSegments = window.location.pathname.split('/');
        const postId = pathSegments[pathSegments.length - 1];
        
        // Try to open the app with custom scheme
        const customSchemeUrl = 'egyakin://post/' + postId;
        
        // Try to open the app
        window.location.href = customSchemeUrl;
        
        // Fallback to app store after delay
        setTimeout(function() {
            if (navigator.userAgent.match(/iPhone|iPad|iPod/i)) {
                window.location.href = 'https://apps.apple.com/eg/app/egyakin/id6738606085';
            } else {
                window.location.href = 'https://play.google.com/store/apps/details?id=com.incode.EgyAkin&hl=en';
            }
        }, 2000);
    </script>
    
    <div style="text-align: center; padding: 50px; font-family: Arial, sans-serif;">
        <h2>Opening EgyAkin...</h2>
        <p>If the app doesn't open automatically, please install it from the app store.</p>
        <div style="margin-top: 30px;">
            <a href="https://apps.apple.com/eg/app/egyakin/id6738606085" 
               style="display: inline-block; margin: 10px; padding: 15px 25px; background: #007AFF; color: white; text-decoration: none; border-radius: 8px;">
                Download for iOS
            </a>
            <a href="https://play.google.com/store/apps/details?id=com.incode.EgyAkin&hl=en" 
               style="display: inline-block; margin: 10px; padding: 15px 25px; background: #01875F; color: white; text-decoration: none; border-radius: 8px;">
                Download for Android
            </a>
        </div>
    </div>
</body>
</html>
```

## How to Get Required Information

### 1. Apple Team ID
1. Go to [Apple Developer Portal](https://developer.apple.com/account/)
2. Click on "Membership" in the left sidebar
3. Your Team ID is displayed there (e.g., "ABC123DEF4")

### 2. Android App Signing Certificate SHA256
1. Get your app's signing certificate
2. Use this command to get the SHA256:
   ```bash
   keytool -list -v -keystore your-keystore.jks -alias your-alias
   ```
3. Look for "SHA256" in the output

## Testing

### Test Universal Links
1. **iOS Simulator:**
   ```bash
   xcrun simctl openurl booted "https://{YOUR_BASE_URL}/post/123"
   ```

2. **Android Emulator:**
   ```bash
   adb shell am start -W -a android.intent.action.VIEW -d "https://{YOUR_BASE_URL}/post/123" com.incode.EgyAkin
   ```

### Test Custom Scheme
1. **iOS Simulator:**
   ```bash
   xcrun simctl openurl booted "egyakin://post/123"
   ```

2. **Android Emulator:**
   ```bash
   adb shell am start -W -a android.intent.action.VIEW -d "egyakin://post/123" com.incode.EgyAkin
   ```

## Troubleshooting

### Common Issues

1. **Universal Links not working:**
   - Check that the files are served with correct Content-Type
   - Verify the files are accessible via HTTPS
   - Ensure the app ID and package name match exactly
   - Check that the certificate SHA256 is correct

2. **Custom scheme not working:**
   - Verify the scheme is properly configured in AndroidManifest.xml and Info.plist
   - Check that the app is installed on the device

3. **Links still opening in browser:**
   - Clear browser cache and app data
   - Reinstall the app after making changes
   - Test on a fresh device/emulator

## Priority Implementation

1. **High Priority:** Implement the HTML redirect page (Option 2)
2. **Medium Priority:** Set up Universal Links (Option 1)
3. **Low Priority:** Optimize the user experience with better fallback handling

## Contact Information

If you need help with the implementation, please contact the mobile development team with:
- Your Apple Team ID
- Your Android app signing certificate SHA256
- Any error messages you encounter 