# Custom Prefs Sync for Firefox
1. Go to about:config (type in URL bar in Firefox)
2. Check which preference you need to sync
3. Create a new boolean value with the name `services.sync.prefs.sync.<pref>` and set it to true
4. Sync Firefox

To delete a pref, go to `$HOME/.mozilla/firefox/<profile-id>/prefs.js` and delete the corresponding value.

[Source](https://developer.mozilla.org/en-US/docs/Archive/Mozilla/Firefox_Sync/Syncing_custom_preferences)
