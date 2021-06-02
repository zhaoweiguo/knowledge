mongo-go-driver项目
###################

* 文档 [1]_

When decoding BSON to a D or M, the following type mappings apply when unmarshalling::

    1. BSON int32 unmarshals to an int32.
    2. BSON int64 unmarshals to an int64.
    3. BSON double unmarshals to a float64.
    4. BSON string unmarshals to a string.
    5. BSON boolean unmarshals to a bool.
    6. BSON embedded document unmarshals to the parent type (i.e. D for a D, M for an M).
    7. BSON array unmarshals to a bson.A.
    8. BSON ObjectId unmarshals to a primitive.ObjectID.
    9. BSON datetime unmarshals to a primitive.Datetime.
    10. BSON binary unmarshals to a primitive.Binary.
    11. BSON regular expression unmarshals to a primitive.Regex.
    12. BSON JavaScript unmarshals to a primitive.JavaScript.
    13. BSON code with scope unmarshals to a primitive.CodeWithScope.
    14. BSON timestamp unmarshals to an primitive.Timestamp.
    15. BSON 128-bit decimal unmarshals to an primitive.Decimal128.
    16. BSON min key unmarshals to an primitive.MinKey.
    17. BSON max key unmarshals to an primitive.MaxKey.
    18. BSON undefined unmarshals to a primitive.Undefined.
    19. BSON null unmarshals to a primitive.Null.
    20. BSON DBPointer unmarshals to a primitive.DBPointer.
    21. BSON symbol unmarshals to a primitive.Symbol.

The above mappings also apply when marshalling a D or M to BSON. Some other useful marshalling mappings are::

    1. time.Time marshals to a BSON datetime.
    2. int8, int16, and int32 marshal to a BSON int32.
    3. int marshals to a BSON int32 if the value is between math.MinInt32 and math.MaxInt32, inclusive, and a BSON int64
    otherwise.
    4. int64 marshals to BSON int64.
    5. uint8 and uint16 marshal to a BSON int32.
    6. uint, uint32, and uint64 marshal to a BSON int32 if the value is between math.MinInt32 and math.MaxInt32,
    inclusive, and BSON int64 otherwise.
    7. BSON null values will unmarshal into the zero value of a field (e.g. unmarshalling a BSON null value into a string
    will yield the empty string.).








.. [1] https://godoc.org/go.mongodb.org/mongo-driver