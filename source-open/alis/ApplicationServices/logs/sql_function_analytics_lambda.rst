lambda函数
###############


Lambda表达式::

    lambda表达式的书写形式为->。

    实例:
    x -> x + 1
    (x, y) -> x + y
    x -> regexp_like(x, 'a+')
    x -> x[1] / x[2]
    x -> IF(x > 0, x, -x)
    x -> COALESCE(x, 0)
    x -> CAST(x AS JSON)
    x -> x + TRY(1 / 0)

filter(array<T>, function<T, boolean>) → ARRAY<T>::

    从一个array中过滤数据，只取满足function返回true的元素。
    SELECT filter(ARRAY [], x -> true); -- []
    SELECT filter(ARRAY [5, -6, NULL, 7], x -> x > 0); -- [5, 7]
    SELECT filter(ARRAY [5, NULL, 7, NULL], x -> x IS NOT NULL); -- [5, 7]

map_filter(map<K, V>, function<K, V, boolean>) → MAP<K,V>::

    从map中过滤数据，只取满足function返回true的元素对。
    SELECT map_filter(MAP(ARRAY[], ARRAY[]), (k, v) -> true); -- {}
    SELECT map_filter(MAP(ARRAY[10, 20, 30], ARRAY['a', NULL, 'c']), 
        (k, v) -> v IS NOT NULL); -- {10 -> a, 30 -> c}
    SELECT map_filter(MAP(ARRAY['k1', 'k2', 'k3'], ARRAY[20, 3, 15]), 
        (k, v) -> v > 10); -- {k1 -> 20, k3 -> 15}

reduce(array<T>, initialState S, inputFunction<S, T, S>, outputFunction<S, R>) → R::

    reduce函数，从初始状态开始，依次遍历array中的每一个元素，
      每次在状态S的基础上，计算inputFunction(s,t)，生成新的状态。
      最终应用outputFunction，把最终状态S变成输出结果R。
    SELECT reduce(ARRAY [], 0, (s, x) -> s + x, s -> s); -- 0
    SELECT reduce(ARRAY [5, 20, 50], 0, (s, x) -> s + x, s -> s); -- 75
    SELECT reduce(ARRAY [5, 20, NULL, 50], 0, (s, x) -> s + x, s -> s); -- NULL
    SELECT reduce(ARRAY [5, 20, NULL, 50], 0, (s, x) -> s + COALESCE(x, 0), s -> s); -- 75
    SELECT reduce(ARRAY [5, 20, NULL, 50], 0, (s, x) -> IF(x IS NULL, s, s + x), s -> s); -- 75
    SELECT reduce(ARRAY [2147483647, 1], CAST (0 AS BIGINT), (s, x) -> s + x, s -> s); -- 2147483648
    计算算数平均值: 10.25
    SELECT reduce(
        ARRAY [5, 6, 10, 20],
        CAST(ROW(0.0, 0) AS ROW(sum DOUBLE, count INTEGER)),
        (s, x) -> CAST(ROW(x + s.sum, s.count + 1) AS ROW(sum DOUBLE, count INTEGER)),
        s -> IF(s.count = 0, NULL, s.sum / s.count)
    );

transform(array<T>, function<T, U>) → ARRAY<U>::

    对数组中的每个元素，依次调用function，生成新的结果U。
    SELECT transform(ARRAY [], x -> x + 1); -- []
    SELECT transform(ARRAY [5, 6], x -> x + 1); -- [6, 7] 表示对每个元素执行加1操作
    SELECT transform(ARRAY [5, NULL, 6], x -> COALESCE(x, 0) + 1); -- [6, 1, 7]
    SELECT transform(ARRAY ['x', 'abc', 'z'], x -> x || '0'); -- ['x0', 'abc0', 'z0']
    SELECT transform(ARRAY [ARRAY [1, NULL, 2], ARRAY[3, NULL]], 
        a -> filter(a, x -> x IS NOT NULL)); -- [[1, 2], [3]]

transform_keys(map<K1, V>, function<K1, V, K2>) → MAP<K2,V>::

    % 依次对map中的每个key应用函数，生成新的key
    SELECT transform_keys(MAP(ARRAY[], ARRAY[]), 
        (k, v) -> k + 1); -- {}
    SELECT transform_keys(MAP(ARRAY [1, 2, 3], ARRAY ['a', 'b', 'c']), 
        (k, v) -> k + 1); -- {2 -> a, 3 -> b, 4 -> c}  表示对每个key执行加1操作。
    SELECT transform_keys(MAP(ARRAY ['a', 'b', 'c'], ARRAY [1, 2, 3]), 
        (k, v) -> v * v); -- {1 -> 1, 4 -> 2, 9 -> 3}
    SELECT transform_keys(MAP(ARRAY ['a', 'b'], ARRAY [1, 2]), (k, v) -> 
        k || CAST(v as VARCHAR)); -- {a1 -> 1, b2 -> 2}
    SELECT transform_keys(MAP(ARRAY [1, 2], ARRAY [1.0, 1.4]), 
      (k, v) -> MAP(ARRAY[1, 2], ARRAY['one', 'two'])[k]); -- {one -> 1.0, two -> 1.4}

transform_values(map<K, V1>, function<K, V1, V2>) → MAP<K, V2>::

    % 对map中的所有value应用function函数，把V1变成V2，生成新的map<K,V2>。
    SELECT transform_values(MAP(ARRAY[], ARRAY[]), 
        (k, v) -> v + 1); -- {}
    SELECT transform_values(MAP(ARRAY [1, 2, 3], ARRAY [10, 20, 30]), 
        (k, v) -> v + 1); -- {1 -> 11, 2 -> 22, 3 -> 33}
    SELECT transform_values(MAP(ARRAY [1, 2, 3], ARRAY ['a', 'b', 'c']), 
        (k, v) -> k * k); -- {1 -> 1, 2 -> 4, 3 -> 9}
    SELECT transform_values(MAP(ARRAY ['a', 'b'], ARRAY [1, 2]), 
        (k, v) -> k || CAST(v as VARCHAR)); -- {a -> a1, b -> b2}
    SELECT transform_values(MAP(ARRAY [1, 2], ARRAY [1.0, 1.4]), 
        (k, v) -> MAP(ARRAY[1, 2], ARRAY['one', 'two'])[k] || '_' || CAST(v AS VARCHAR));
        -- {1 -> one_1.0, 2 -> two_1.4}

zip_with(array<T>, array<U>, function<T, U, R>) → array<R>::

    合并两个array，通过函数指定生成的新的array中的元素。
    第一个数组的元素T和第二个数组元素U，生成新的结果R。
    SELECT zip_with(ARRAY[1, 3, 5], ARRAY['a', 'b', 'c'], 
        (x, y) -> (y, x)); 
    --表示调换前后两个数组的元素位置，生成一个新的数组。
      结果： [ROW('a', 1), ROW('b', 3), ROW('c', 5)]
    SELECT zip_with(ARRAY[1, 2], ARRAY[3, 4], (x, y) -> x + y); 
    -- 结果[4, 6]
    SELECT zip_with(ARRAY['a', 'b', 'c'], ARRAY['d', 'e', 'f'], 
        (x, y) -> concat(x, y)); 
    表示把前后两个数组的元素拼接，生成一个新的字符串。结果： ['ad', 'be', 'cf']

map_zip_with(map<K, V1>, map<K, V2>, function<K, V1, V2, V3>) → map<K, V3>::

    合并两个map，针对每个key，由两个value V1和V2生成V3。生成新的Map <K,V3>。
    SELECT map_zip_with(MAP(ARRAY[1, 2, 3], ARRAY['a', 'b', 'c']), 
                    MAP(ARRAY[1, 2, 3], ARRAY['d', 'e', 'f']),
                    (k, v1, v2) -> concat(v1, v2));  表示把两个map key相同的value进行合并。
                    -- {1 -> ad, 2 -> be, 3 -> cf}
    SELECT map_zip_with(MAP(ARRAY['k1', 'k2'], ARRAY[1, 2]), 
                        MAP(ARRAY['k2', 'k3'], ARRAY[4, 9]),
                        (k, v1, v2) -> (v1, v2));表示把两个value生成一个数组。
                        -- {k1 -> ROW(1, null), k2 -> ROW(2, 4), k3 -> ROW(null, 9)}
    SELECT map_zip_with(MAP(ARRAY['a', 'b', 'c'], ARRAY[1, 8, 27]), 
                        MAP(ARRAY['a', 'b', 'c'], ARRAY[1, 2, 3]),
                        (k, v1, v2) -> k || CAST(v1/v2 AS VARCHAR)); 表示在结果中连接key的值和两个value的相除结果
                        -- {a -> a1, b -> b4, c -> c9}























