.. _php_excel:

php excel使用文档
##########################



phpexcel 在数据量大的时候经常内存泄漏问题
----------------------------------------------------------------

设置缓存 需要1.7.6版本才支持硬盘缓存::

    $cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_discISAM; 
    $cacheSettings = array(); 
    PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);

    $objPHPExcel = new PHPExcel();






