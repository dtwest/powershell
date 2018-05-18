Function Split([String]$String, [String]$Regex){
        $RegexMatch = [Regex]::Match($String, $Regex);

        [String[]]$Strings = @("","");

        $Strings[0] = $RegexMatch.Value;
        $Strings[1] = $String.Substring($RegexMatch.length);

        return $Strings;
}