<?php
/*
 * 注释说明
 */
if (defined('ENVIRONMENT'))
{
	switch (ENVIRONMENT)
	{
		case 'development':
			break;
		default:
			exit('The application environment is not set correctly.');
	}
}
