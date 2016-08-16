Gem::Specification.new do |s|
  s.name = 'logstash-input-oss'
  s.version = '1.0.0'
  s.licenses = ['MIT']
  s.summary = 'Stream events from OSS bucket logging files'
  s.description = 'This gem is a logstash input plugin for streaming OSS bucket logging files'
  s.authors = ['yami']
  s.email = 'yamisoe@hotmail.com'
  s.require_paths = ['lib']

  s.files =   ["Gemfile", "README.md", "lib/logstash/inputs/oss.rb", "logstash-input-oss.gemspec", "spec/inputs/oss_spec.rb", "spec/inputs/sincedb_spec.rb"]
  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_dependency "aliyun-sdk", "~> 0.3.6"
  s.add_dependency "snappy"
  s.add_runtime_dependency "logstash-core", ">= 2.0.0.beta2", "< 3.0.0"
  s.add_runtime_dependency 'stud', '~> 0.0.18'
  s.add_development_dependency 'logstash-devutils'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency "logstash-codec-plain"
end
