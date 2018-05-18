## Just for fun, rotation of a square 2D array.

$Global:Array = @(@(1..4),@(5..8),@(9..12),@(13..16));

Function Transpose() {
    for ($i = 0; $i -lt 4; $i++){
        for ($j = 0; $j -lt $i; $j++){
            Swap $i $j $j $i;
        }
    }
}

Function Swap($OldRow, $OldCol, $NewRow, $NewCol) {
    $temp = $Global:Array[$OldRow][$OldCol];
    $Global:Array[$OldRow][$OldCol] = $Global:Array[$NewRow][$NewCol];
    $Global:Array[$NewRow][$NewCol] = $temp;
}

Function Flip() {
    for ($i = 0; $i -lt 4; $i++){
        for ($j = 0; $j -lt 2; $j++){
            Swap $i $j $i (3-$j);
        }
    }
}

$Array | % {$_ -join ','}
Transpose;
Flip;
$Array | % {$_ -join ','}