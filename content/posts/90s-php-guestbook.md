---
title: "90s PHP Guestbook"
date: 2023-03-10T16:01:37Z
draft: false
---

I was watching a video about the [90s web](https://www.youtube.com/watch?v=ZSBYO1BYrDM) and heard something so amusingly stupid by today's standards that I had to try it out.

<!--more-->

Using scripts to edit HTML based on user input was a common practice. This is something you only want to try at home because it raises a lot of security issues. But I wanted to take this idea to the next level.

Why would I separate the html from the script? The script can provide the html and edit **itself**.

Now that is what I call a **single** source of truth and the most PHP thing I can think of.

**I call this ouroboros programming.**

## The golden script

You can find this piece of art [here](https://github.com/hrvthzslt/90s-php-guestbook). It's all in one script, so I
would like to point out the three most questionable parts:

### Permissions

The script itself has to be readable, executable and writable by the webserver. Traditionally another script would write the html itself, but that is not cursed enough.

### Redirect

The script has to do a redirect after the form is submitted; otherwise, the change won't be visible. If the script includes the entries from another file, there would be no need for a redirect.

### Inserting the guestbook entries

This is where the magic happens.

```php
function addEntry(string $name, string $message): void
{
    $name = strip_tags($name);
    $message = strip_tags($message);
    $entry = "
        <tr>
            <td>$name</td>
            <td>$message</td>
            <td>" . date('Y-m-d H:i:s') . "</td>
        </tr>
    ";
    $content = file_get_contents('index.php');
    $pattern = '<!-- ENTRIES -->';
    $content = preg_replace('/' . $pattern . '/', $pattern . $entry, $content, 1);
    file_put_contents('index.php', $content);
}
```

TL;DR: Replace the string `<!-- ENTRIES -->` with itself and the new entry.

Of course, the first time I replaced all occurrences, which broke the script. After that, I contemplated how I should replace only the first occurrence. I found some threads and read that the `substr_replace` method would be the most performant, so I chose `preg_replace`.

To summarize the PHP script reads itself, replaces some part and rewrites itself with the whole content. This is such
a horrible solution that it makes me love it even more.

### Bonus

There is an addition check in the form for catching those damn robots, but I let you discover it for yourself.
