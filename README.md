# flutter_nfc_hce_reader

"Flutter NFC Hce Reader Example"

## NFC HCE Reader Example

"The Nfc Hce Reader Example is a sample that utilizes the nfc_manager library to read NFC host card emulation tags on Android. 
 The Nfc Hce Aid used is D2760000850101."

## Setup 
 "Reference: https://pub.dev/packages/nfc_manager"

**Android Setup**

* Add [android.permission.NFC](https://developer.android.com/reference/android/Manifest.permission.html#NFC) to your `AndroidManifest.xml`.
   ````xml
    <uses-permission android:name="android.permission.NFC" />
    <uses-feature android:name="android.hardware.nfc" android:required="true" />
    <uses-feature android:name="android.hardware.nfc.hce" android:required="true" />
   ````

**iOS Setup**

* Add [Near Field Communication Tag Reader Session Formats Entitlements](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_nfc_readersession_formats) to your entitlements.
    ````xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
	<key>com.apple.developer.nfc.readersession.formats</key>
	<array>
	    <string>NDEF</string>
		<string>TAG</string>
	</array>
    </dict>
    </plist>
    ````

* Add [NFCReaderUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nfcreaderusagedescription) to your `Info.plist`.
* Add [com.apple.developer.nfc.readersession.felica.systemcodes](https://developer.apple.com/documentation/bundleresources/information_property_list/systemcodes) and [com.apple.developer.nfc.readersession.iso7816.select-identifiers](https://developer.apple.com/documentation/bundleresources/information_property_list/select-identifiers) to your `Info.plist` as needed.
    ````xml
    <key>com.apple.developer.nfc.readersession.felica.systemcodes</key>
    <array>
    <string>0000</string>
    </array>
    <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
    <array>
    <string>D2760000850101</string>
    </array>
    ````
