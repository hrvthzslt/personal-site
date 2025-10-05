+++
date = '2025-10-05T18:10:39Z'
draft = false
title = 'How QMK Documentation Humbled Me (Again)'
+++

I had the dorkiest **Tap Hold** problem with my keyboard, I tried to retrain my muscle memory, I checked all kind of forums. I should have checked the official documentation instead.

<!--more-->

## The Problem

I use **Tap Hold** functionality quite aggressively on my keyboard. If you're not familiar, the point is that a key does a thing when it's _tapped_ and another when it's _held_, so **Tap Hold**. You can read more details about it [here](/posts/create-custom-keyboard-layout-with-qmk-for-no-reason).

This functionality has an associated timeout of activation, but in my experience the best experience is achieved with an option called: `HOLD_ON_OTHER_KEY_PRESS`. The effect of it is that when a **Tap Hold** key is held witn another key the **Hold** mapping will be in affect immediately. I have _control_ mapped to **Hold**, so this way when I press _control + c_, that happens without timeout. It is very very smooth.

But there is a phenomenon during typing called _roll over_, that is when you're finger are pressing different keys after another, there is little time when multiple keys are pressed.

Why that is a problem? I wanted a **Tap Hold** mapping with space, but when I type my fingers are rolling over space and the other keys, so the **Hold** binding is activated.

## The Solution

**Read the friendly documentation!**

As it turned out ([again](/posts/qmk-userspaces-and-a-silly-man)), starting with the documentation would have yielded much more results, than searching the _interwebz_ and calling all my _agents_ to duty.

I wanted exceptions for the `HOLD_ON_OTHER_KEY_PRESS` settings, and in the docs I would have found that is a feature already built in with another settings `HOLD_ON_OTHER_KEY_PRESS_PER_KEY`. Makes sense!

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

Pressing the key will yield a _space_ holding it an _alt_, when it's pressed _"hold on other key press"_ will not activate.

## Moralizing

So in the end I would like to point out why _documentations_ and _books_ are great source of information. When they are well organized and written they provide much more than how you should use a technology. They can provide a guided learning path. They can provide context about the design decisionsand goals. So if you're lucky you can learn _why_ is something works like it does not just _how_.

This was a celebration of my foolishness and a better typing experience. Thank you for reading it!
