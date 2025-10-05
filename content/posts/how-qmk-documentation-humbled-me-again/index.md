+++
date = '2025-10-05T18:10:39Z'
draft = false
title = 'How QMK Documentation Humbled Me (Again)'
+++

I had the dorkiest problem with my keyboard. I tried to retrain my muscle memory, and I checked all kinds of forums. I should have checked the official documentation instead.

<!--more-->

## The Problem

I use **Tap Hold** functionality quite aggressively on my keyboard. If you're not familiar, the idea is that a key does one thing when it's _tapped_ and another when it's _held_, hence **Tap Hold**. You can read more details about it [here](/posts/create-custom-keyboard-layout-with-qmk-for-no-reason).

This functionality has an associated activation timeout, but in my experience, the best results come from an option called `HOLD_ON_OTHER_KEY_PRESS`. The effect is that when a **Tap Hold** key is held with another key, the **Hold** mapping is active immediately. I have _control_ mapped to **Hold**, so when I press _control + c_, that happens without any delay. It is very, very smooth.

However, there is a phenomenon during typing called _roll over_: when your fingers press different keys one after another, there is a short moment when multiple keys are pressed.

Why is that a problem? I wanted a **Tap Hold** mapping with space, but when I type my fingers roll over space and other keys, so the **Hold** binding is activated unintentionally.

## The Solution

**Read the friendly documentation!**

As it turned out ([again](/posts/qmk-userspaces-and-a-silly-man)), starting with the documentation would have yielded much better results than searching the _interwebz_ or calling all my _agents_ to duty.

I wanted exceptions for the `HOLD_ON_OTHER_KEY_PRESS` setting, and in the docs I would have found that this feature is already built in with another setting: `HOLD_ON_OTHER_KEY_PRESS_PER_KEY`. Makes sense!

This is how it looks in practice:

```c
#define HOLD_ON_OTHER_KEY_PRESS_PER_KEY

#define MT_ALSP MT(MOD_LALT,KC_SPC)

bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case MT_ALSP:
            // Do not select the hold action when another key is pressed.
            return false;
        default:
            // Immediately select the hold action when another key is pressed.
            return true;
    }
}
```

Pressing the key will yield a _space_, holding it yields _alt_. When it's pressed, _"hold on other key press"_ will not activate.

## Moralizing

So in the end I would like to point out why _documentation_ and _books_ are great sources of information. When they are well organized and written, they provide much more than just instructions for using a technology. They can provide a guided learning path, context about design decisions and goals. If you're lucky, you can learn _why_ something works the way it does, not just _how_.

This was a celebration of my foolishness, and a better typing experience. Thank you for reading!
