<?php

$admin_email = 'your_email@example.com';

function cachedir($r)
{
	return "{$GLOBALS['basedir']}/files";
}

function bindto($r)
{
	return "0:0";
}
