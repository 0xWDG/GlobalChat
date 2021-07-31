<?php
function generateRandomString($length = 65) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+()~><';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}

for ( $i=0; $i<1000; $i++ )
{
	$e = null;

	if ( $i > 99 )
		$e = null;
	elseif ( $i < 100 && $i > 9)
		$e = "0";
	elseif ( $i < 10)
		$e = "00";
	else
		$e = "000";


	echo "    [self setValue:@\"".generateRandomString()."{$e}{$i}\" forKey:@\"".generateRandomString()."{$e}{$i}\"];\n";
}

?>