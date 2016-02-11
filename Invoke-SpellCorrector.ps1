function Invoke-SpellCorrector($word) {
    
    $alphabet = 'abcdefghijklmnopqrstuvwxyz'

    function deletion {
	    (0..($word.Length-1)) | ForEach { @($word.Substring(0,$_) + $word.Substring($_+1)) }
    }

    function transposition {
	    @((0..($word.Length-2)) | ForEach {
		    $word.Substring(0, $_) + $word[$_+1] + $word[$_] + $word.Substring($_+2)
		    }
	    )
    }

    function alteration {
	    foreach($i in (0..($word.Length - 1)) ) {
            forEach($c in $alphabet.GetEnumerator()) {
			    @($word.substring(0,$i)+$c+$word.substring($i+1))
		    }
	    }
    }

    function insertion {
	    $n = $word.Length
	    forEach($i in (0..(($n - 1) + 1))) {
		    $alphabet.GetEnumerator() | foreach { @($word.substring(0,$i)+$_+$word.substring($i)) }
	    }
    }

    function train {
        $h = @{}    
        forEach ($word in [regex]::split([System.IO.File]::ReadAllText("$pwd\holmes.txt").ToLower(), ‘\W+’) ) {
            $h[$word]=0        
        }
        
        $h.psbase.keys|sort
    }

    $trained = train    
    #foreach(
    #    #$targetWord in ((deletion $word) + (transposition $word) + (insertion $word) + (alteration $word))
    #    $targetWord in (
    #        (deletion $word) +
    #        (transposition $word) + 
    #        (insertion $word) + 
    #        (alteration $word)
    #    )
    #) { 
    #    $trained -eq $targetWord 
    #}
    
    (deletion $word) + (transposition $word) + (insertion $word) + (alteration $word) |
        forEach {$trained -eq $_}
}