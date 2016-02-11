Peter Norvig, Director of Research at Google, posted ["How to Write a Spelling Corrector"](http://norvig.com/spell-correct.html).

The PowerShell version reads a text file that has ~110K words, creates a lookup dictionary, and produces a list of possible corrections based on the edit distance between two words. See Mr. Norvig's post for details.

All this in a page of PowerShell script, and it comes back in less than a second.