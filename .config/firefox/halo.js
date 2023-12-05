
// These are my custom overrides on arkenfox.js

// open previous tabs on startup:
user_pref("browser.startup.page", 3);

// enable custom userChrome.js:
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// disable social media ads in the URL bar:
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.suggest.topsites", false); // [FF78+]

// do not prefil forms:
user_pref("signon.prefillForms", false);

// do not prefil credit cards:
user_pref("extensions.formautofill.creditCards.enabled", false);

// do not autosave passwords:
user_pref("signon.rememberSignons", false);

// enable the addition of search keywords:
user_pref("keyword.enabled", true);

// don't autodelete history on shutdown:
user_pref("privacy.clearOnShutdown.history", false);

// disable letterboxing (the borders around the website):
user_pref("privacy.resistFingerprinting.letterboxing", false);

// this could otherwise cause some issues on bank logins and other annoying sites:
user_pref("network.http.referer.XOriginPolicy", 0);

// enable DRM support:
user_pref("media.eme.enabled", true);

// fix the issue where right mouse button instantly clicks
user_pref("ui.context_menus.after_mouseup", true);
