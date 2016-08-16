# encoding: utf-8

require "logstash/inputs/oss"
require "fileutils"
require "tmpdir"

describe LogStash::Inputs::Oss::SinceDB::File do
  let!(:dirname) { File.join(Dir.tmpdir,SecureRandom.hex) }
  let!(:pathname) { File.join(dirname, SecureRandom.hex) }
  let!(:sincedb) { LogStash::Inputs::Oss::SinceDB::File.new(pathname) }

  after (:each) { FileUtils.remove_entry_secure(dirname, true) }

  it 'should create all parent dirs and the file with empty marker' do
    expect(File.exists?(pathname)).to eq(true)
    expect(sincedb.marker).to eq('')
  end

  it 'should save the marker and reload should get the same marker' do
    marker = 'marker-1'

    sincedb.marker = marker
    expect(sincedb.marker).to eq(marker)

    reload_db = LogStash::Inputs::Oss::SinceDB::File.new(pathname)
    expect(reload_db.marker).to eq(marker)
  end
end
