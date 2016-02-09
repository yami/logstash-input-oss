require "logstash/inputs/oss"
require "time"

def fetch_events(settings)
  queue = []
  oss = LogStash::Inputs::Oss.new(settings)
  oss.register
  oss.process_new_objects(queue)
  queue
end

describe LogStash::Inputs::Oss do
    let(:config) {
      {
       "access_key_id" => "1234",
       "access_key_secret" => "secret",
       "endpoint" => "http://oss-cn-hangzhou.aliyuncs.com",
       "bucket" => "logstash-test"
      }
    }

  it "should generate events" do
    remote_key = "MyLog-oss-example-2012-09-10-04-00-00-0000"
    content = '10.152.68.117 - - [26/Jan/2016:08:38:12 +0800] "PUT /logging/ming-oss-share2016-01-26-03-00-00-0001 HTTP/1.1" 200 25 20 "-" "-" "ming-oss-share.oss-cn-hangzhou-b.aliyuncs.com" "56A6BFF4CA78F70E9F53CE90" "true" "1047205513514293" "PutObject" "ming-oss-share" "logging%2Fming-oss-share2016-01-26-03-00-00-0001" - 4 "-" 985 "1047205513514293" 709 "-" "-"'
    objects = [Aliyun::OSS::Object.new(
                                      :key => remote_key,
                                      :type => "Normal",
                                      :size => content.length,
                                      :etag => "FAKE-ETAG",
                                      :last_modified => Time.now.rfc822)]
    mock_bucket = double("bucket")
    allow(mock_bucket).to receive(:list_objects) { objects }
    allow(mock_bucket).to receive(:get_object) do |key, opts|
      expect(key).to eq(remote_key)
      expect(opts.has_key?(:file)).to eq(true)

      File.open(File.expand_path(opts[:file]), 'wb') do |f|
        f.write(content)
      end
    end

    allow(Aliyun::OSS::Bucket).to receive(:new) { mock_bucket }
    
    events = fetch_events(config)
    expect(events.size).to eq(1)
  end
end
