# Wispr iOS Takehome

This repo shows off the creation of a custom keyboard for iOS using the Fleksy SDK. See prompt [here](https://wispr.notion.site/Wispr-iOS-Challenge-3cfcbc0010794ca79cc6192a77268bd4).

## Basic Premise

For this take home project I took inspiration from instagram bios. Instagram and many other social apps don't natively support changing fonts within your profile so often you'll see people using unicode characters to add their own style to their bios.

The keyboard I implemented has a pull out menu that allows users to select between a few different Unicode "Typefaces" that I put together. Once a user selects the typeface they want to use, the keyboard automatically changes the characters as you type.

## Demo
<p align="center">
    <a href="https://github.com/StevenWorrall/wispr/tree/main/app_demo.gif"><img src="https://github.com/StevenWorrall/wispr/tree/main/app_demo.gif" height=400px width=auto ></a>
    <a href="https://github.com/StevenWorrall/wispr/tree/main/keyboard_demo.gif"><img src="https://github.com/StevenWorrall/wispr/tree/main/keyboard_demo.gif" height=400px width=auto ></a>
</p>

## Running the Project

In order for the project to run, you must add your license key and secret key as Environment Variables. To do this go to: Product -> Scheme -> Edit Scheme. In the Run tab and under Arguments, two variables should be added to the Environment Variables section.
> fleksyLicenseKey
> fleksySecretKey

After this, follow the instructions in the [Fleksy quick start guide](https://docs.fleksy.com/sdk-ios/#launch-and-debug) to add the keyboard to your device. 

## Implementation Specifics

I first created a JSON file that hard coded mappings from regular english Unicode characters to the desired typeface unicode characters. This would make it easy to use a dictionary lookup later for the character replacement.

The model "[TypefaceModel](https://github.com/StevenWorrall/wispr/tree/main/wispr_takehome/wispr_keyboard/Typeface/TypefaceModel.swift)" I created has a convert function contained in it for easy and quick access. This function basically takes any length string and uses the conversion table to convert character by character in the string. If a character isn't in our conversion table, it leaves that as is.

```
func convert(_ text: String) -> String {
    return String(text.map { Character(conversionTable[String($0)] ?? String($0)) })
}
```

In order to get the JSON data to our view, I process it in the [View Model](https://github.com/StevenWorrall/wispr/tree/main/wispr_takehome/wispr_keyboard/Typeface/TypefaceSelectorViewModell.swift) which just reads the JSON file and parses it into the aforementioned TypefaceModel.

All of the typefaces are put into an array and shown to the user in a simple Collection View shown in [TypefaceSelectorView](https://github.com/StevenWorrall/wispr/tree/main/wispr_takehome/wispr_keyboard/Typeface/TypefaceSelectorView.swift).

Actually changing the text while typing is as simple as using one of the built in features of Fleksy. You can see Fleksy's docs for more specifics on their [EventBus](https://docs.fleksy.com/sdk-ios/api-reference-ios/eventbus/).


### Future Upgrades and things I didn't get to

- Additional typefaces -- this should be as easy as making a few more entries in the JSON file with other viable Unicode characters.

- The app portion just currently has instructions on how to add the keyboard to your device but it would be nice to have a list of all supported "Typefaces" in that app and allow users to customize which ones show up and in what order they do so. I could have probably done this using Core Data.

- Support for custom keyboards. This could just be a cool gimic between friends but you could allow users to create their own keyboard mappings which would produce a sort of (easily decryptable) encrypted way of talking! This would be as easy as creating new mappings on the fly like in the "Typefaces.json" file and serving them up using the functionality created above.

  

### Known Edge Cases and Bugs

- Unicode characters aren't represented as english letters so anything typed with the keyboard using unicode characters won't be able to be read with accessibility features.

- Swipe to type on keyboard inserts only default characters.

- Auto Capitalization makes the character default back to normal characters.
