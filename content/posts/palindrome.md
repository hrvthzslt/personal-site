---
title: "Palindrome"
date: 2023-03-30T08:56:56Z
draft: true
---

Some time ago I was in the "going to job interviews" business. I applied to developer roles which usually means there will be at least some coding involved, and this fact can manifest itself during an interview.\
So near the end of an interview I got a task to write two solutions for detecting if a word is a palindrome. I did that, both worked and the live coding switched to other topics. We never really talked about the quality or complexity of the solution.

## The solution

I will show the first solution:
```php
class Solution
{
    public function isPalindrome(string $text): bool
    {
        return strtolower($text) === strtolower(strrev($text));
    }
}
```
The second solution was really similar, but it does not matter because this is how I would do it on a Monday. In a sense this solution is not about solving the problem, but producing the correct output with the correct builtin functions. It is correct, it is how I would do it again... but maybe I should have gone deeper.

## Have to go deeper

Since the task is to tell if a word is a palindrome, I have to check if the input equals the reverse of the input. `strrev` does exactly this, but what if I want to implement it.
```php
function strrev(string $text)
{
    $characters = str_split($text);

    $i = 0;
    $j = count($characters) - 1;

    while ($i < $j) {
        $temp = $characters[$i];
        $characters[$i] = $characters[$j];
        $characters[$j] = $temp;

        $i++;
        $j--;
    }

    return implode($characters);
}
```
I make my own hand dirty and reverse it myself. Reverse the `0`-th and `n - 1`-th items in the array, then the `1`-th and `n - 2`-th, and so on until the two sides meet.\
This is the main part of the solution, if the interview were focused on algorithms, this would be a legitimate answer even if the problem itself is quite easy.\
But I can go deeper.

## More deeper

In the `strrev` method, I transformed the string to an array then back to a string. I should do this on a dedicated datatype, on a character chain. In PHP, I can implement it as a class.

```php
class CharacterChain
{
    private string $value;
    private int $length;

    public function __construct(string $text)
    {
        $this->value = $text;
        $this->length = strlen($text);
    }

    public function getValue(): string
    {
        return $this->value;
    }

    public function getLength(): int
    {
        return $this->length;
    }

    public function getCharacter(int $i): string
    {
        return substr($this->value, $i, 1);
    }

    public function setCharacter(int $i, string $char): void
    {
        $this->value = substr_replace($this->value, substr($char, 0, 1), $i, 1);
    }

}
```

This class represents a character chain which can be constructed from a chain of characters ;). This way a list of same typed values (the characters) with a predefined length can be stored, just like a real array. It can jump to a concrete character with an index, and it can only change a character under an index, there is no way to add or remove a character, again... just like a real array. Somewhere between this code lines there is some missing error handling but palind**rome** were not built in one code session.\
This changes the implementation of the `strrev` method.

```php
function strrev(string $text): string
{
    $characters = new CharacterChain($text);

    $i = 0;
    $j = $characters->getLength() - 1;

    while ($i < $j) {
        $temp = $characters->getCharacter($i);
        $characters->setCharacter($i, $characters->getCharacter($j));
        $characters->setCharacter($j, $temp);

        $i++;
        $j--;
    }

    return $characters->getValue();
}
```

## Mooore deeper

There is one more function I could implement and I don't want to leave it hanging. One of the solution to implement the `strtolower` function is to walk through the character chain and if the letter is uppercase do a little dance in the ASCII table like this: `chr(ord('A') + 32)`. I did not do that, I wanted a more crude solution which make more use of the `CharacterChain`.

```php
function strtolower(string $text): string
{
    $characters = new CharacterChain($text);
    $abc = range('a', 'z');
    $ABC = range('A', 'Z');

    for ($i = 0; $i < $characters->getLength(); $i++) {
        if (false !== $j = array_search($characters->getCharacter($i), $ABC)) {
            $characters->setCharacter($i, $abc[$j]);
        }
    }

    return $characters->getValue();
}
```

This loop check every character, if the character is found in the list with the uppercase letters it will swap the character to a lowercase one.

## Mooore deeeper

In `strtolower` function I used `array_search` to determine if a letter is uppercase, that should be implemented just for the kicks as well. This one is just a binary search which returns the position of the found item or returns `false`.

```php
function array_search($needle, array $haystack): int|bool
{
    $characters = new CharacterChain(implode($haystack));
    $low = 0;
    $high = $characters->getLength();

    while ($low < $high) {
        $i = floor(($low + $high) / 2);
        $value = $characters->getCharacter($i);

        if ($needle === $value) {
            return $i;
        } elseif ($needle < $value) {
            $high = $i;
        } else {
            $low = $i + 1;
        }
    }

    return false;
}
```

## The result

For this whole shenanigan I created a [repository](https://github.com/hrvthzslt/palindrome) where you can admire the whole code. With such miracles as function namespaces I was able to use the same function names as their builtin siblings'. And of course there is a test for the solution.\
Maybe next time in an interview I will go deeper, you certainly should.