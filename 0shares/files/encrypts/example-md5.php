<?php

//md5 碰撞示范，数据不同，md5值一样

$a = <<< EOT
d131dd02c5e6eec4693d9a0698aff95c
2fcab58712467eab4004583eb8fb7f89
55ad340609f4b30283e488832571415a
085125e8f7cdc99fd91dbdf280373c5b
d8823e3156348f5bae6dacd436c919c6
dd53e2b487da03fd02396306d248cda0
e99f33420f577ee8ce54b67080a80d1e
c69821bcb6a8839396f9652b6ff72a70
EOT;

$b = <<< EOT
d131dd02c5e6eec4693d9a0698aff95c
2fcab50712467eab4004583eb8fb7f89
55ad340609f4b30283e4888325f1415a
085125e8f7cdc99fd91dbd7280373c5b
d8823e3156348f5bae6dacd436c919c6
dd53e23487da03fd02396306d248cda0
e99f33420f577ee8ce54b67080280d1e
c69821bcb6a8839396f965ab6ff72a70
EOT;


$a = str_replace("\n","",$a);
$a = hex2bin($a);

$b = str_replace("\n","",$b);
$b = hex2bin($b);

assert($a !=$b);

echo md5($a);
echo "\n";
echo md5($b);
echo "\n";