---
title: "Palindrome"
date: 2023-03-30T08:56:56Z
draft: true
---

Some time ago I was in the "going to job interviews" business. I applied to developer roles which usually means there will be coding involved, and this fact can manifest itself during an interview.\
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
The second solution was really similar but it does not matter because this is how I would do it on a Monday. In a sense this solution is not about solving the problem, but producing the correct output with the correct builtin functions. It is correct, it is how I would do it again... but maybe I should have gone deeper.
## We have to go deeper
Since the task is to tell if a word is a palindrome, we have to check if the input equals the reverse of input. `strrev` does exactly this, but what if we need to implement it.
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
We make our hand dirty and reverse it ourselves. Reverse the `0` and `n - 1` items in the array, then the `1` and `n - 2`, and so on until the two sides meet.