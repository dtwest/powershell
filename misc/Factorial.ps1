Function Factorial([Int]$n){
    
    if ($n  -lt 2){
        return 1;
    }

    return $n * (Factorial($n - 1));

}