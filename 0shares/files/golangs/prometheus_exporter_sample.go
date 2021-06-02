package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, exportData)
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}

var exportData string = `# HELP sample_http_requests_total The total number of HTTP requests.
# TYPE sample_http_requests_total counter
sample_http_requests_total{method="post",code="200"} 1027 1395066363000
sample_http_requests_total{method="post",code="400"}    3 1395066363000

# Escaping in label values:
sample_msdos_file_access_time_seconds{path="C:\\DIR\\FILE.TXT",error="Cannot find file:\n\"FILE.TXT\""} 1.458255915e9

# Minimalistic line:
sample_metric_without_timestamp_and_labels 12.47

# A histogram, which has a pretty complex representation in the text format:
# HELP sample_http_request_duration_seconds A histogram of the request duration.
# TYPE sample_http_request_duration_seconds histogram
sample_http_request_duration_seconds_bucket{le="0.05"} 24054
sample_http_request_duration_seconds_bucket{le="0.1"} 33444
sample_http_request_duration_seconds_bucket{le="0.2"} 100392
sample_http_request_duration_seconds_bucket{le="0.5"} 129389
sample_http_request_duration_seconds_bucket{le="1"} 133988
sample_http_request_duration_seconds_bucket{le="+Inf"} 144320
sample_http_request_duration_seconds_sum 53423
sample_http_request_duration_seconds_count 144320

# Finally a summary, which has a complex representation, too:
# HELP sample_rpc_duration_seconds A summary of the RPC duration in seconds.
# TYPE sample_rpc_duration_seconds summary
sample_rpc_duration_seconds{quantile="0.01"} 3102
sample_rpc_duration_seconds{quantile="0.05"} 3272
sample_rpc_duration_seconds{quantile="0.5"} 4773
sample_rpc_duration_seconds{quantile="0.9"} 9001
sample_rpc_duration_seconds{quantile="0.99"} 76656
sample_rpc_duration_seconds_sum 1.7560473e+07
sample_rpc_duration_seconds_count 2693
`