#!/usr/bin/env ruby

require 'fileutils'
require 'json'

recover = ARGV[0] == '-r'

if recover
  dict = JSON.parse(File.read('tmp/dict.json'))

  dict.each.with_index do |image_path, i|
    FileUtils.mv("tmp/#{i}", image_path)
  end

  File.delete('tmp/dict.json')
else
  dict = []
  FileUtils.mkdir('tmp') unless File.exists?('tmp')

  Dir['*/**/*.psd', '*/**/*.ai'].each.with_index do |image_path, i|
    FileUtils.mv(image_path, "tmp/#{i}")
    dict[i] = image_path
  end

  File.open('tmp/dict.json', 'w') do |file|
    file.write(dict.to_json)
  end
end