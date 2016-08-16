#Logstash Input Plugin for Aliyun OSS Logging

*Warning: This is still a work in progress. Do not use it for production.*

Aliyun OSS (Open Storage Service) offers a feature called Bucket Logging.
Once this feature is enabled, OSS pushes your bucket's access logs to specified bucket (i.e. target bucket)
with customized filename prefix (i.e. target prefix).

This Logstash input plugin collects access logs from OSS. That's it.


## TODOs
* test cases
* error handling
* robust logstash grok pattern

## Sample Logstash Configuration
```
input {
  oss {
    type => "application/octet-stream"
    endpoint => "<endpoint>"
    access_key_id => "<your-access-key-id>"
    access_key_secret => "<your-access-key-secret>"
    bucket => "<your-target-bucket>"
    prefix => "<your-target-prefix>"
    compression_type => "<compression_type>" none:snappy
  }
}

filter {
    grok {
      match => {"message" => "%{IP:remote_ip} - - \[%{HTTPDATE:time}\] \"%{WORD:method} %{NOTSPACE:url} HTTP/%{NUMBER:http_version}\" %{NUMBER:status} %{NUMBER:length} %{NUMBER:latency} %{QS:referrer} %{QS:user_agent} %{QS:host} \"%{WORD:request_id}\" \"%{WORD:logging_flag}\" \"%{NOTSPACE:requester}\" \"%{NOTSPACE:operation}\" \"%{NOTSPACE:bucket}\" \"%{NOTSPACE:key}\" %{NOTSPACE:object_size} %{NOTSPACE:turn_around_time} \"%{NOTSPACE:error_code}\" %{NUMBER:in_length} \"%{NOTSPACE:bucket_owner}\" %{NOTSPACE:delta_size} \"%{NOTSPACE:sync_request}\" \"-\""}
    }
}
```
